class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:destroy]

  def index
    @users = policy_scope(User)
    @users = @users.where(id: params[:id].to_i) if params[:id]
    @users = @users.paginate(:page => params[:page], :per_page => 30)
    users = User.all
    @weekly_users = users.where('created_at > ?', Time.current - 1.week).count
    @total_users = users.count
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
