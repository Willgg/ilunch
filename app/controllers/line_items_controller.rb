class LineItemsController < ApplicationController
  before_action :set_product, only: [:create]
  before_action :set_order, only: [:create]

  def create
    @line_item = @order.line_items.build(line_item_params.merge(product: @product))
    if @line_item.save
      redirect_to order_path(@order)
    else
      redirect_to products_path
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
