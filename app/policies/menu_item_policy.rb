class MenuItemPolicy < ApplicationPolicy

  def index?
    user.admin? || user.chef?
  end

  def create?
    true
  end

  class Scope < Scope
    def resolve
      (user.admin? || user.chef?) ? scope.all : scope.where(user: user)
    end
  end
end
