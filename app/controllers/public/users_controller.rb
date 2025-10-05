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
  end

  def publish_unpublish
  end

  def unsubscribe
  end

  def withdraw
  end
end
end
