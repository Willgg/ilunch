class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :new, :update]

  before_action :set_order, only: [:show, :new, :update]
  after_action :verify_authorized, except: [:show, :new, :update]

  def show
    authorize(@order, @order.id, :show?)
  end

  def new
    @menus = policy_scope(Menu)
    @products = Product.category(params[:step]).of_the_day(Date.current)
    @line_item = @order.line_items.select{ |e| !e.menu_id.nil? }.last
    @menu_item = MenuItem.new
    @line_item = LineItem.new if params[:step] == 'extra' || params[:step] == 'menu'
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
    super
    if @order.nil?
      @order = Order.create
      session[:order_id] = @order.id
    end
    @order = Order.find(params[:id]) if params[:id]
    update_order_with_user
  end

  def order_params
    params.require(:order).permit(:company_id)
  end

  def authorize(record, id, method)
    unless OrderPolicy.new(current_user, record, id).send(method.to_sym)
      redirect_to menus_path
    end
  end
end
