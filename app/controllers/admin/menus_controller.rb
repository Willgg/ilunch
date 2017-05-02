class Admin::MenusController < ApplicationController
  before_action :set_menu, only: [:edit, :update, :destroy]

  def index
    @menus = policy_scope(Menu).paginate(:page => params[:page], :per_page => 30)
  end

  def new
    @menu = Menu.new
    authorize @menu
  end

  def create
    @menu = Menu.new(menu_params)
    authorize @menu
    if @menu.save
      flash[:notice] = 'Le menu a bien été ajouté !'
      redirect_to admin_menus_path
    else
      render :new
    end
  end

  def edit
    authorize @menu
  end

  def update
    authorize @menu
    @menu.update(menu_params)
    redirect_to admin_menus_path
  end

  def destroy
    authorize @menu
    @menu.destroy
    redirect_to admin_menus_path
  end

  private

  def menu_params
    params.require(:menu).permit(:title, :active, :price, :photo, :main, :dessert, :drink)
  end

  def set_menu
    @menu = Menu.find(params[:id])
  end
end
