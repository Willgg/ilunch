class Admin::LineItemsController < ApplicationController

  def index
    @line_items = policy_scope(LineItem)
    @line_items = @line_items.where(order_id: params[:order]) if params[:order]
    @line_items = @line_items.paginate(:page => params[:page], :per_page => 30)
  end
end
