class LineItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :destroy]

  before_action :set_product, only: [:create]
  before_action :set_menu, only: [:create]
  before_action :set_order, only: [:create]
  before_action :set_line_item, only: [:destroy]

  def create
    # if @order.line_items.where(menu: @menu).exists?
    #   @line_item = @order.line_items.where(menu: @menu).first
    #   @line_item.quantity += params[:line_item][:quantity].to_i
    # else
    if params[:line_item].has_key?(:product_id)

      if @order.line_items.where(product_id: params[:line_item][:product_id]).present?
        @line_item = @order.line_items.find_by(product_id: params[:line_item][:product_id].to_i)
        @line_item.quantity += params[:line_item][:quantity].to_i
      else
        @line_item = @order.line_items.build(line_item_params)
      end
    else
      @line_item = @order.line_items.build(line_item_params.merge(menu: @menu))
    end
    authorize @line_item

    if @line_item.is_a_product? && @line_item.save
      respond_to do |format|
         format.html { redirect_to new_order_payment_path(@order) }
         format.js
      end
    elsif @line_item.is_a_menu? && @line_item.save
      respond_to do |format|
        format.html { redirect_to new_order_path(step: Product::CATEGORIES[0]) }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to menus_path }
        format.js
      end
    end
  end

  def destroy
    authorize @line_item
    if @line_item.destroy
      if @line_item.order.line_items.count <= 0
        redirect_to root_path
      else
        redirect_to(:back)
      end
    else
      flash[:error] = 'Le produit n\'a pas pu être supprimé'
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id]) if params[:product_id]
  end

  def set_menu
    @menu = Menu.find(params[:menu_id]) if params[:menu_id]
  end

  def set_line_item
    begin
      @line_item = LineItem.find(params[:id])
    rescue
      redirect_to root_path
    end
  end

  def line_item_params
    params.require(:line_item).permit(:quantity, :product_id)
  end

  def set_order
    attributes = {user: current_user} if current_user
    super
    create_order(attributes) if @order.nil?
    update_order(attributes)
  end
end
