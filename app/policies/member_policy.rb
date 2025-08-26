class MemberPolicy < ApplicationPolicy
  # --- Permisos CRUD básicos ---
  def index?
    user.admin? || user.secretary?
  end

  def show?
    user.admin? || user.secretary? || record.id == user.member.id
  end

  def create?
    user.admin? || user.secretary?
  end

  def update?
    user.admin? || user.secretary?
  end

  def destroy?
    user.admin?
  end

  def reactivate?
    user.admin? || user.secretary?
  end

  # --- Parámetros de filtrado permitidos en index ---
  # Este método devuelve una lista de keys que el controlador
  # podrá pasar a `params.permit(...)` para el scope de filtrado.
  def allowed_filters
    if user.admin?
      %i[
        status
        created_from
        created_to
        birthdate_from
        birthdate_to
        upcoming_in_days
        search
        age_min
        age_max
      ]
    elsif user.secretary?
      # el secretario quizá solo filtre por estado y búsqueda básica
      %i[
        status
        search
        age_min
        age_max
      ]
    else
      # ningún filtro para roles sin permiso de listado
      []
    end
  end

  # --- Scope para Pundit en index ---
  class Scope < Scope
    def resolve
      return scope.none unless user

      if user.admin? || user.secretary?
        scope.all
      elsif user.member_id.present?
        scope.where(id: user.member_id)  # solo su propio member
      else
        scope.none
      end
    end
  end
end
