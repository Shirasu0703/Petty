module Public
class UsersController < ApplicationController
  before_action :authenticate_user!

  def mypage
    @user = current_user
    # ログインユーザーの投稿したレビューを新しい順に取得とページネーション
    @reviews = @user.reviews.order(created_at: :desc)
    # .page(params[:page]).per(6)
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(para,s[:id])
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to mypage_public_users_path, notice: "ユーザー情報を更新しました"
    else
      render :edit
    end
  end

  def publish_unpublish
  end

  def unsubscribe
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.update(is_active: false)
    reset_session
    redirect_to new_user_registration_path, notice: "退会が完了しました。ご利用ありがとうございました。"
  end

  
  private

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :image)
  end
end
end
