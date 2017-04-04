class LineItemPolicy < ApplicationPolicy

  def index?
    user.admin? || user.chef?
  end

  def create?
    true
  end

  def destroy?
    user == record.order.user && !( record.order.status == 0 )
  end

  class Scope < Scope
    def resolve
      user.admin? || user.chef? ? scope.all : scope.where(user: user)
    end
  end
end
