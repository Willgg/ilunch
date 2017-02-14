class OrderPolicy < ApplicationPolicy

  def show?
    # Class initialized with session[:order_id] as :user
    user == record.id || user == record.user
  end

  class Scope < Scope
    def resolve
      user.admin? ? scope.all : scope.where(user: user)
    end
  end
end
