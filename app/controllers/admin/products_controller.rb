class Admin::ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :destroy]

  def index
    @products = policy_scope(Product).paginate(:page => params[:page], :per_page => 30)
  end

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    authorize @product
    if @product.save
      flash[:notice] = 'Le produit a bien été ajouté !'
      redirect_to admin_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    authorize @product
    @product.update(product_params)
    redirect_to admin_products_path
  end

  def destroy
    authorize @product
    @product.destroy
    redirect_to admin_products_path
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :photo, :price)
  end
end
