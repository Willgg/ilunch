class PaymentPolicy < Struct.new(:user, :payment)
  def create?
    raise
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
