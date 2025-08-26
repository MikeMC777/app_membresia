class MemberSerializer < ActiveModel::Serializer
  attributes :id,
             :full_name,
             :first_name,
             :second_name,
             :first_surname,
             :second_surname,
             :email,
             :phone,
             :status,
             :status_humanized,
             :birth_date,
             :age,
             :baptism_date,
             :marital_status_humanized,
             :gender_humanized,
             :wedding_date,
             :membership_date,
             :address,
             :city,
             :state,
             :country,
             :active

  # Solo para usuarios con permiso (ej. admin/secretary), expón deleted_at
  attribute :deleted_at, if: :show_deleted_at?

  # Resumen de equipos y el rol del miembro en cada uno
  has_many :team_roles, if: :include_team_roles?

  def full_name
    [object.first_name, object.second_name, object.first_surname, object.second_surname]
      .reject(&:blank?)
      .join(" ")
  end

  def age
    return unless object.birth_date

    now = Date.current
    age = now.year - object.birth_date.year
    age -= 1 if Date.new(now.year, object.birth_date.month, object.birth_date.day) > now
    age
  end

  def active
    object.active?
  end

  def status_humanized
    object.status_human
  end

  def marital_status_humanized
    object.marital_status_human if object.marital_status
  end

  def gender_humanized
    object.gender_human if object.gender
  end

  def show_deleted_at?
    # Asume que scope es el current_user; ajustar según tu convención
    current_user = scope
    current_user&.admin? || current_user&.secretary?
  end

  def include_team_roles?
    # Solo incluir si lo solicita el cliente vía param o si es admin
    !!instance_options[:include_team_roles]
  end
end
