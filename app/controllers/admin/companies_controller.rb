class Admin::CompaniesController < ApplicationController
  before_action :set_company, only: [:edit, :update, :destroy]

  def index
    @companies = policy_scope(Company).paginate(:page => params[:page], :per_page => 30)
  end

  def new
    @company = Company.new
    authorize @company
  end

  def create
    @company = Company.new(company_params)
    authorize @company
    if @company.save
      redirect_to admin_companies_path
    else
      render :new
    end
  end

  def edit
    authorize @company
  end

  def update
    authorize @company
    @company.update(company_params)
    redirect_to admin_companies_path
  end

  def destroy
    authorize @company
    if @company.destroy
      flash[:notice] = 'L\'entreprise a bien été supprimée'
    else
      flash[:alert] = 'L\'entreprise n\'a pas été supprimée'
    end
    redirect_to admin_companies_path
  end

  private

  def company_params
    params.require(:company).permit(:name, :street, :post_code, :city, :delivery_time)
  end

  def set_company
    @company = Company.find(params[:id])
  end
end
