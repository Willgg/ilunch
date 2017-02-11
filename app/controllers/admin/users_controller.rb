class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:destroy]

  def index
    @users = User.all
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
