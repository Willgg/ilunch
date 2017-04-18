class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :authenticate_admin!, :set_order
  before_action :configure_permitted_parameters, if: :devise_controller?

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: user_params_list)
    devise_parameter_sanitizer.permit(:account_update, keys: user_params_list)
  end

  private

  def set_order
    fetch_order
  end

  def fetch_order
    if session[:order_id]
      @order = Order.find(session[:order_id])
    elsif current_user
      @order = Order.where(user: current_user).future.pending.last
      session[:order_id] = @order.id unless @order.blank?
    end
  end

  def create_order(attributes=nil)
    @order = Order.create(attributes)
    session[:order_id] = @order.id
  end

  def update_order(attributes=nil)
    return if attributes.nil?
    @order.user = attributes[:user] if attributes[:user] && @order.user.nil?
    @order.date = attributes[:date] if attributes[:date]
    @order.destroy_line_items
    @order.save
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^pages$)/
  end

  def authenticate_admin!
    if params[:controller] =~ /^admin/ && !(current_user.admin? || current_user.chef?)
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

  def user_params_list
    [:dob, :gender, :company_id, :first_name, :last_name, :street, :post_code, :city, :phone]
  end

end
