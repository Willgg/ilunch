class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :set_order

  def set_order
    @order = Order.find(session[:order_id]) unless session[:order_id].nil?
  end
end
