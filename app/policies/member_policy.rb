class MemberPolicy < ApplicationPolicy
  # Solo Secretario y Administrador pueden ver la lista de miembros
  def index?
    user.admin? || user.secretary?
  end

  def show?
    user.admin? || user.secretary?
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
end

