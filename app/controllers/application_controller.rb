class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :authenticate_admin!, :set_order
  before_action :configure_permitted_parameters, if: :devise_controller?

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:company_id, :first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:company_id, :first_name, :last_name, :street, :post_code, :city])
  end

  private

  def set_order
    if session[:order_id]
      @order = Order.find(session[:order_id])
    elsif current_user && current_user.orders.pending.exists?
      @order = Order.where(user: current_user).pending.last
      session[:order_id] = @order.id
    end
    update_order_with_user unless @order.nil?
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^pages$)/
  end

  def authenticate_admin!
    if params[:controller] =~ /^admin/ && !current_user.admin?
      redirect_to root_path
    end
  end

  def after_sign_in_path_for(resource)
    if @order && request.referer == new_order_payment_url(@order)
      request.referer
    else
      root_path
    end

  end

  def after_sign_up_path_for(resource)
    if request.referer == new_order_payment_url(@order)
      request.referer
    else
      root_path
    end
  end

  def update_order_with_user
    return unless current_user && @order.user.nil?
    @order.user = current_user
    @order.save
  end
end
