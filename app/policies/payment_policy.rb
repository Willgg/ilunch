class PaymentPolicy < ApplicationPolicy

  def initialize(user, record, session)
    @user = user
    @record = record
    @session = session
  end

  def new?
    raise
    @record.user ? ( @record.user == @user ) : ( @record.id == @session )
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
