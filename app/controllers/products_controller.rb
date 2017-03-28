class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, :only => :index

  def index
    @products_of_week = policy_scope(Product).of_the_week
    @products_of_day = @products_of_week.of_the_day(Date.today)
    @products_of_week -= @products_of_day
    @line_item = LineItem.new
  end
end
