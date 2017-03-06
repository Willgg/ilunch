class UserPolicy < ApplicationPolicy

  def destroy?
    user.admin? || user == record
  end

  class Scope < Scope
    def resolve
      user.admin? ? scope.all : scope.where(id: user.id)
    end
  end
end
