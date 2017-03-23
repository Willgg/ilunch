class MenuItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def create
    @menu_item = MenuItem.new(menu_item_params)
    @menu_item.menu = Menu.find(params[:menu_id])
    authorize @menu_item

    if @menu_item.save
      if @menu_item.menu.full?
        redirect_to new_order_payment_path(@order)
      else
        redirect_to new_order_path(step: @menu_item.menu.next_step)
      end
    else
      redirect_to new_order_path(step: params[:step])
    end
  end

  private

  def menu_item_params
    params.require(:menu_item).permit(:quantity, :product_id)
  end
end
