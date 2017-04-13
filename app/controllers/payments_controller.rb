class PaymentsController < ApplicationController
  skip_before_action :authenticate_user!

  before_action :set_order
  after_action :verify_authorized, except: [:new, :create], unless: :skip_pundit?

  def new
    @user = user_signed_in? ? current_user : User.new
    redirect_to root_path unless authorize(@order, session[:order_id], :new?)
  end

  def create
    if authorize(@order, session[:order_id], :create?)
      if @order.products_out_of_stock.present?
        flash[:alert] = "Le produit n'est plus en stock"
        redirect_to new_order_payment_path(@order)
      else
        begin

          if current_user.stripe_id.nil?
            customer = Stripe::Customer.create(
              source: params[:stripeToken],
              email:  params[:stripeEmail]
            )
            current_user.update(stripe_id: customer.id) if customer.id
          end

          charge = Stripe::Charge.create(
            customer:     current_user.stripe_id, # You should store this customer id and re-use it.
            amount:       @order.total_price_cents, # or amount_pennies
            description:  "Payment for order#{@order.id}",
            currency:     @order.total_price.currency
          )

          case charge.status
          when 'succeeded'
            @order.update(payment: charge.to_json, status: 1)
            @order.substract_products_stocks
            @order.send_confirmation_email
            session.delete(:order_id)
          when 'pending'
            @order.update(payment: charge.to_json, status: 0)
          when 'failed'
            @order.update(payment: charge.to_json, status: 2)
          end

          redirect_to order_path(@order)

        rescue Stripe::CardError => e
          flash[:error] = e.message
          redirect_to new_order_payment_path(@order)
        end
      end
    else
      redirect_to products_path
    end
  end

  private

  def set_order
    begin
      @order = Order.find(params[:order_id])
      update_order_with_user unless @order.nil?
    rescue
      redirect_to root_path
    end
  end

  def authorize(record, session, method)
    PaymentPolicy.new(current_user, record, session).send(method)
  end
end
