class MenuItemPolicy < ApplicationPolicy

  def create?
    true
  end

  class Scope < Scope
    def resolve
      ( user.admin? ? scope.all : scope.where(user: user) )
    end
  end
end
