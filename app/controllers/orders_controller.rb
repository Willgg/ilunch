class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :update]

  before_action :set_order, only: [:show, :update]
  after_action :verify_authorized, except: :show

  def show
    authorize(@order, session[:order_id], :show?)
  end

  def update
    authorize(@order, session[:order_id], :update?)
    if @order.update(order_params)
      respond_to do |format|
        format.html { redirect_to order_path(@order)}
        format.js
      end
    else
      repsond_to do |format|
        format.html { redirect_to edit_order_path(@order)}
        format.js
      end
    end

  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:company_id)
  end

  def authorize(record, id, method)
    unless OrderPolicy.new(current_user, record, id).send(:method)
      redirect_to products_path
    end
  end
end
