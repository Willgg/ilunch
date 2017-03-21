class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :new, :update]

  before_action :set_order, only: [:show, :new, :update]
  after_action :verify_authorized, except: [:show, :update]

  def show
    authorize(@order, session[:order_id], :show?)
  end

  def new
    @products = Product.all
    @line_item = LineItem.new
  end

  def update
    authorize(current_user, @order, session[:order_id])
    if @order.update(order_params)
      respond_to do |format|
        format.html { redirect_to new_order_payment_path(@order)}
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to new_order_payment_path(@order)}
        format.js
      end
    end
  end

  private

  def set_order
    @order = Order.find(params[:id]) if params[:id]
    super
    if @order.nil?
      @order = Order.create
      session[:order_id] = @order.id
    end
    update_order_with_user
  end

  def order_params
    params.require(:order).permit(:company_id)
  end

  def authorize(record, id, method)
    unless OrderPolicy.new(current_user, record, id).send(method.to_sym)
      redirect_to products_path
    end
  end
end
