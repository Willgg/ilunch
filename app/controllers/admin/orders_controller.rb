class Admin::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update]

  after_action :verify_authorized, except: [:index,:update], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def index
    @orders = policy_scope(Order)
    if any_params?
      @orders = @orders.where(user: params[:user]) if params[:user]
      @orders = @orders.where(status: params[:status]) if params[:status]
      @orders = @orders.where(id: params[:id]) if params[:id]
    else
      @orders = @orders.done.order(status: :asc)
    end
    @orders = @orders.paginate(:page => params[:page], :per_page => 30)
  end

  def show
  end

  def update
    @order.ready! if @order.payed? && ( current_user.admin? || current_user.chef? )
    respond_to do |format|
      format.html { redirect_to admin_orders_path }
      format.js
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit()
  end

  def any_params?
    !(params[:user].nil? && params[:status].nil? && params[:id].nil?)
  end

end
