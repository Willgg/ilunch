class Admin::LineItemsController < ApplicationController

  def index
    @line_items = policy_scope(LineItem).paginate(:page => params[:page], :per_page => 30)
  end
end
