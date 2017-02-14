class PaymentsController < ApplicationController

  after_action :verify_authorized, except: [:new, :create], unless: :skip_pundit?

  before_action :set_order

  def new
  end

  def create
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

  private

  def set_order
    @order = Order.pending.find(params[:order_id])
  end
end
