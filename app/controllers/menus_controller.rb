class MenusController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  respond_to :html, :js, only: [:index]

  def index
    @menus = policy_scope(Menu)
    date = params[:date].nil? ? Date.today : Date.parse(params[:date])
    @products = Product.category('main').available_for(date)
    @products_of_week = Product.category('main').of_the_week.sample(5)
    @line_item = LineItem.new
  end
end
