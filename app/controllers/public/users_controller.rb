module Public
class UsersController < ApplicationController
  def mypage
    @user = current_user
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
