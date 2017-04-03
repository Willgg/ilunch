class OrderPolicy < ApplicationPolicy
  attr_reader :user, :record, :session

  def initialize(user, record, session)
    @user = user
    @record = record
    @session = session
  end

  def index?
    @user.admin? || @user.chef?
  end

  def show?
    @record.payed? && ( @record.user ? ( @record.user == @user ) : ( @record.id == @session ) )
  end

  def create?
    true
  end

  def update?
    @record.user ? ( @record.user == user ) : ( @record.id == @session )
  end

  def ready_for_delivery?
    ( user.admin? || user.chef? ) && record.payed?
  end

  class Scope < Scope
    def resolve
      ( user.admin? || user.chef? ) ? scope.all : scope.where(user: user)
    end
  end
end
