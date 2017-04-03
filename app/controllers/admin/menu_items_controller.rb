class Admin::MenuItemsController < ApplicationController

  require 'will_paginate/array'

  def index
    @menu_items = policy_scope(MenuItem)
    @menu_items = @menu_items.where(line_item_id: params[:line_item].to_i) if params[:line_item]
    @menu_items = @menu_items.sort { |x,y| x.product.date <=> y.product.date }
    @menu_items = @menu_items.paginate(:page => params[:page], :per_page => 30)
  end
end
