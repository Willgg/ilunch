class MenusController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @menus = policy_scope(Menu)
    @line_item = LineItem.new
  end
end
