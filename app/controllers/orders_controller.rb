class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :new, :update]

  before_action :set_order, only: [:show, :new, :update]
  after_action :verify_authorized, except: [:show, :new, :update]

  def show
    authorize(@order, session[:order_id], :show?)
  end

  def new
    @menus = policy_scope(Menu)
    @products = Product.category(params[:step]).of_the_day(@order.date)
    @menu_item = MenuItem.new
    @line_item = LineItem.new
    unless params[:step] == 'extra' || params[:step] == 'menu'
      @line_item = @order.line_items.select{ |li| !li.menu_id.nil? }.last
    end
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
    attributes = {}
    attributes = attributes.merge( date: Date.parse(params[:date]) ) if params[:date]
    attributes = attributes.merge( user: current_user ) if current_user
    @order = Order.find(params[:id]) if params[:id]
    super
    if @order.nil?
      create_order(attributes)
    else
      update_order(attributes)
    end
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
