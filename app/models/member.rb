class Member < ApplicationRecord
  acts_as_paranoid

  # Asociaciones
  has_many :team_roles
  has_many :teams, through: :team_roles

  has_many :tasks_created, class_name: 'Task', foreign_key: :created_by_id, dependent: :nullify
  has_many :tasks_assigned, class_name: 'Task', foreign_key: :assigned_to_id, dependent: :nullify

  has_many :attendances, dependent: :destroy
  has_many :attendance_confirmations, dependent: :destroy
  has_many :task_comments, dependent: :destroy

  has_one :user, dependent: :destroy

  # Validaciones
  validates :first_name, :first_surname, presence: true
  validates :email, presence: true, uniqueness: true

  # Enums
  enum marital_status: { single: 0, married: 1, divorced: 2, widowed: 3 }
  enum gender: { male: 0, female: 1 }
  enum status: { active: 0, inactive: 1, sympathizer: 2 }

  # Callbacks
  after_initialize :set_default_status, if: :new_record?

  # Métodos útiles
  def full_name
    [first_name, second_name, first_surname, second_surname].compact.join(" ")
  end

  def active?
    status == "active"
  end

  def set_default_status
    self.status ||= :sympathizer
  end

  def must_start_as_sympathizer
    errors.add(:status, "debe iniciar como simpatizante") unless status == "sympathizer"
  end
end

