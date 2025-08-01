class MemberPolicy < ApplicationPolicy
  # Acciones permitidas
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

  # Scope para limitar los resultados de index
  class Scope < Scope
    def resolve
      if user.admin? || user.secretary?
        scope.all
      else
        scope.none
      end
    end
  end
end
