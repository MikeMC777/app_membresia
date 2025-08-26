class Member < ApplicationRecord
  acts_as_paranoid

  # Asociaciones
  has_many :team_roles, dependent: :destroy
  has_many :teams, through: :team_roles

  has_many :tasks_created, class_name: 'Task', foreign_key: :created_by_id, dependent: :nullify
  has_many :tasks_assigned, class_name: 'Task', foreign_key: :assigned_to_id, dependent: :nullify

  has_many :attendances, dependent: :destroy
  has_many :attendance_confirmations, dependent: :destroy
  has_many :task_comments, dependent: :destroy

  has_one :user, dependent: :destroy

  # Enums
  enum marital_status: { single: 0, married: 1, divorced: 2, widowed: 3, common_law_marriage: 4 }
  enum gender: { male: 0, female: 1 }
  enum status: { active: 0, inactive: 1, sympathizer: 2 }

  # Callbacks
  before_validation :normalize_email
  after_initialize :set_default_status, if: :new_record?

  # Validaciones
  validates :first_name, :first_surname, :email, presence: true
  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            uniqueness: { case_sensitive: false }
  validates :birth_date, presence: true
  validate :must_start_as_sympathizer, on: :create

  # Scopes de filtrado (no aplican si el valor es nil o cadena vacía)
  scope :with_status,       ->(status_name) { where(status: statuses[status_name]) if status_name.present? }
  scope :created_from, ->(v) {
    t = try_time(v)
    t ? where(arel_table[:created_at].gteq(t)) : all
  }

  scope :created_to, ->(v) {
    t = try_time(v)
    t ? where(arel_table[:created_at].lteq(t)) : all
  }

  scope :with_created_between, ->(min, max) {
    created_from(min).created_to(max)
  }

  scope :birthdate_from, ->(v) {
    d = try_date(v)
    d ? where(arel_table[:birth_date].gteq(d)) : all
  }

  scope :birthdate_to, ->(v) {
    d = try_date(v)
    d ? where(arel_table[:birth_date].lteq(d)) : all
  }

  scope :with_birthdate_between, ->(min, max) {
    birthdate_from(min).birthdate_to(max)
  }
  scope :with_upcoming_birthday_in_days, ->(days) do
    d = days.to_i
    d = 0 if d.negative?

    start_date = Date.current
    end_date   = start_date + d.days

    start_key = start_date.strftime('%m%d').to_i
    end_key   = end_date.strftime('%m%d').to_i

    # Clave de comparación mes/día (cero‐rellenado) como entero: 0103 => 103
    key_sql = "to_char(birth_date, 'MMDD')::int"

    if end_key >= start_key
      where("#{key_sql} BETWEEN ? AND ?", start_key, end_key)
    else
      # Cruce de fin de año: ej. 12/30..01/03
      where("#{key_sql} >= ? OR #{key_sql} <= ?", start_key, end_key)
    end
  end
  # Busca en los campos de Member (y/o User) sin distinguir mayúsculas ni tildes
  scope :search_user, ->(term) {
    return all if term.blank?

    # Escapamos %, _ para LIKE
    sanitized = ActiveRecord::Base.sanitize_sql_like(term.strip)
    pattern   = "%#{sanitized}%"

    # Construimos la condición con UNACCENT + ILIKE
    cols = %w[first_name second_name first_surname second_surname email phone address]
    conditions = cols.map { |c| "unaccent(#{c}) ILIKE unaccent(?)" }.join(" OR ")
    where([conditions, *Array.new(cols.size, pattern)])
  }

  # Edad >= min: nacido en o antes de hoy - min años
  scope :with_age_min, ->(min) {
    cutoff = Date.current.years_ago(Integer(min)) rescue nil
    cutoff ? where(arel_table[:birth_date].lteq(cutoff)) : none
  }

  # Edad <= max: nacido en o después de hoy - (max+1) años + 1 día (aprox inclusivo)
  scope :with_age_max, ->(max) {
    max_i = Integer(max) rescue nil
    next none unless max_i
    lower_bound = Date.current.years_ago(max_i + 1) + 1.day
    where(arel_table[:birth_date].gteq(lower_bound))
  }

  scope :with_age_between, ->(min, max) {
    with_age_min(min).with_age_max(max)
  }

  # -------- Helpers de parseo seguro --------
  def self.try_time(value)
    return nil if value.blank?
    Time.zone.parse(value.to_s)
  rescue ArgumentError, TypeError
    nil
  end

  def self.try_date(value)
    return nil if value.blank?
    Date.parse(value.to_s)
  rescue ArgumentError, TypeError
    nil
  end

  # Método único para aplicar todos los filtros recibidos
  def self.filter_by(params = {})
    members = all
    members = members.with_status(params[:status]) if params[:status].present?
    members = members.created_from(params[:created_from]) if params[:created_from].present? && !params[:created_to].present?
    members = members.created_to(params[:created_to]) if params[:created_to].present? && !params[:created_from].present?
    members = members.with_created_between(params[:created_from], params[:created_to]) if params[:created_to].present? && params[:created_from].present?
    members = members.birthdate_from(params[:birthdate_from]) if params[:birthdate_from].present? && !params[:birthdate_to].present?
    members = members.with_birthdate_between(params[:birthdate_from], params[:birthdate_to]) if params[:birthdate_from].present? && params[:birthdate_to].present?
    members = members.birthdate_to(params[:birthdate_to]) if params[:birthdate_to].present? && !params[:birthdate_from].present?
    members = members.with_upcoming_birthday_in_days(params[:upcoming_in_days]) if params[:upcoming_in_days].present?
    members = members.search_user(params[:search])
    members = members.with_age_min(params[:age_min]) if params[:age_min].present? && !params[:age_max].present?
    members = members.with_age_max(params[:age_max]) if params[:age_max].present? && !params[:age_min].present?
    members = members.with_age_between(params[:age_min], params[:age_max]) if params[:age_min].present? && params[:age_max].present?
    members
  end



  # Métodos útiles
  def full_name
    [first_name, second_name, first_surname, second_surname].reject(&:blank?).join(" ")
  end

  def status_human
    I18n.t("activerecord.attributes.member.statuses.#{status}")
  end

  def gender_human
    I18n.t("activerecord.attributes.member.genders.#{gender}")
  end

  def marital_status_human
    I18n.t("activerecord.attributes.member.marital_statuses.#{marital_status}")
  end

  # alias redundantes eliminados: Rails ya define `active?` por el enum

  private

  def set_default_status
    self.status ||= :sympathizer
  end

  def must_start_as_sympathizer
    return if status == "sympathizer"

    errors.add(:status, "must start as sympathizer") 
  end

  def normalize_email
    self.email = email.to_s.downcase.strip
  end
end
