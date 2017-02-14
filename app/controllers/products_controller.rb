class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, :only => :index

  def index
    @products = policy_scope(Product).all
    @line_item = LineItem.new
  end
end
