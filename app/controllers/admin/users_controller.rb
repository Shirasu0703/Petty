class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ユーザー情報を更新しました"
    else
      render :edit
    end
  end

  def activate
    @user = User.find(params[:id])
    if @user.update(is_active: true)
      redirect_to admin_users_path, notice: "ユーザーを有効にしました。"
    else
      redirect_to admin_users_path, alert: "有効化に失敗しました。"
    end
  end
  
  def deactivate
    @user = User.find(params[:id])
    if @user.update(is_active: false)
      redirect_to admin_users_path, notice: "ユーザーを無効にしました。"
    else
      redirect_to admin_users_path, alert: "無効化に失敗しました。"
    end
  end
  

  private

  def user_params
    params.require(:user).permit(:user_id, :name, :email, :introduction, :is_active)
  end

end
