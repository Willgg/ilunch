class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.paginate(:page => params[:page], :per_page => 30)
  end
end
