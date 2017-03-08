class PaymentsController < ApplicationController
  skip_before_action :authenticate_user!

  before_action :set_order
  after_action :verify_authorized, except: [:new, :create], unless: :skip_pundit?

  def new
    @user = user_signed_in? ? current_user : User.new
    authorize(@order, session[:order_id], :new?)
  end

  def create

    if authorize(@order, session[:order_id], :update?)
      begin
        customer = Stripe::Customer.create(
          source: params[:stripeToken],
          email:  params[:stripeEmail]
        )

        charge = Stripe::Charge.create(
          customer:     customer.id,   # You should store this customer id and re-use it.
          amount:       @order.total_price_cents, # or amount_pennies
          description:  "Payment for order#{@order.id}",
          currency:     @order.total_price.currency
        )

        @order.update(payment: charge.to_json, status: 1)
        session.delete(:order_id)
        redirect_to order_path(@order)

      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_order_payment_path(@order)
      end
    else
      redirect_to products_path
    end
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  end

  def authorize(record, session, method)
    PaymentPolicy.new(current_user, record, session).send(method)
  end
end
