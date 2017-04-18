class MenusController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  respond_to :html, :js, only: [:index]

  def index
    @menus = policy_scope(Menu)
    @products = Product.category('main').available_between(days[0], days[-1])
    @products_of_week = Product.category('main').of_the_week.sample(5)
    @line_item = LineItem.new
  end

  private

  def days
    Ilunch.next_active_days(5, Date.current)
  end
end
