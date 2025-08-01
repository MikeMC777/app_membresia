class MemberDecorator < Draper::Decorator
  delegate_all

  # Nombre completo con formato legible
  def full_name
    [object.first_name, object.second_name, object.first_surname, object.second_surname]
      .compact.join(' ')
  end

  # Fecha de nacimiento en formato legible
  def birth_date_formatted
    object.birth_date&.strftime("%d/%m/%Y")
  end

  def membership_date_formatted
    object.membership_date&.strftime("%d/%m/%Y")
  end

  # Estado legible y capitalizado
  def status_badge
    case object.status
    when 'active'
      h.content_tag(:span, 'Activo', class: 'badge bg-success')
    when 'inactive'
      h.content_tag(:span, 'Inactivo', class: 'badge bg-danger')
    when 'sympathizer'
      h.content_tag(:span, 'Simpatizante', class: 'badge bg-warning')
    end
  end

  # Género legible
  def gender_label
    { 'male' => 'Masculino', 'female' => 'Femenino' }[object.gender.to_s]
  end

  # Estado civil legible
  def marital_status_label
    {
      'single' => 'Soltero/a',
      'married' => 'Casado/a',
      'divorced' => 'Divorciado/a',
      'widowed' => 'Viudo/a'
    }[object.marital_status.to_s]
  end
end
