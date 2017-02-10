class Admin::ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :destroy]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = 'Le produit a bien été ajouté !'
      redirect_to admin_path
    else
      render :new
    end
  end

  def edit
  end

  def destroy
    @product.destroy
    redirect_to admin_path
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :photo)
  end
end
