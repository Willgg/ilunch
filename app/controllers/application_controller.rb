class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :authenticate_admin!, :set_order

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def set_order
    if session[:order_id]
      @order = Order.find(session[:order_id])
    elsif current_user && current_user.orders.pending
      @order = Order.where(user: current_user).pending.first
      session[:order_id] = @order.id
    else
      @order = nil
    end
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^pages$)/
  end

  def authenticate_admin!
    if params[:controller] =~ /^admin/ && !current_user.admin?
      redirect_to root_path
    end
  end
end
