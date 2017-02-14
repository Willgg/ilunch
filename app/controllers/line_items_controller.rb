class LineItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  before_action :set_product, only: [:create]
  before_action :set_order, only: [:create]

  def create
    if @order.line_items.where(product: @product).exists?
      @line_item = @order.line_items.where(product: @product).first
      @line_item.quantity += params[:line_item][:quantity].to_i
    else
      @line_item = @order.line_items.build(line_item_params.merge(product: @product))
    end
    authorize @line_item

    if @line_item.save
      respond_to do |format|
         format.html { redirect_to order_path(@order) }
         format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to products_path }
        format.js
      end
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def line_item_params
    params.require(:line_item).permit(:quantity)
  end

  def set_order
    begin
      @order = Order.find(session[:order_id])
    rescue ActiveRecord::RecordNotFound
      @order = Order.create
      session[:order_id] = @order.id
    end
  end
end
