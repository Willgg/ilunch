class MenuItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    @menu_item = MenuItem.new(menu_item_params)
    @menu_item.line_item = LineItem.find(params[:line_item_id])
    authorize @menu_item
    @menu_item.save
    line_item = LineItem.find(@menu_item.line_item_id)
    if line_item.full?
      redirect_to new_order_payment_path(@order)
    else
      redirect_to new_order_path(step: line_item.next_step)
    end
  end

  private

  def menu_item_params
    params.require(:menu_item).permit(:quantity, :product_id)
  end
end
