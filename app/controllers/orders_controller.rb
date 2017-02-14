class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  before_action :set_order, only: [:show]
  after_action :verify_authorized, except: :show

  def show
    authorize(@order, session[:order_id])
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def authorize(order, order_id)
    unless OrderPolicy.new(order_id, order).show?
      redirect_to products_path
    end
  end
end
