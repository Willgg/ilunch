class Admin::CompaniesController < ApplicationController
  before_action :set_company, only: [:destroy]

  def index
    @companies = Company.paginate(:page => params[:page], :per_page => 30)
  end

  def destroy
    @company.destroy
    redirect_to admin_companies_path
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end
end
