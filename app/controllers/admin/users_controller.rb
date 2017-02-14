class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:destroy]

  def index
    @users = policy_scope(User).paginate(:page => params[:page], :per_page => 30)
  end

  def destroy
    authorize @user
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
