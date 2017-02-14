class Admin::OrdersController < ApplicationController

  def index
    @orders = policy_scope(Order).paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @order = Order.find(params[:id])
  end
end
