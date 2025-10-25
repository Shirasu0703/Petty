class Public::FavoritesController < ApplicationController
  before_action :reject_guest_user, only: [:create, :destroy]
  before_action :set_hospital_and_review

  def create
    favorite = current_user.favorites.find_or_create_by(review_id: @review.id)
    # favorite.save
    # redirect_to request.referer
    # redirect_to params[:redirect_path].presence || public_hospital_review_path(@hospital, @review)
  end

  def destroy
    favorite = current_user.favorites.find_by(review_id: @review.id)
    favorite.destroy
    # redirect_to request.referer
    # redirect_to params[:redirect_path].presence || public_hospital_review_path(@hospital, @review)
  end

  private

  def set_hospital_and_review
    @hospital = Hospital.find(params[:hospital_id])
    @review = Review.find(params[:review_id])
  end

  def reject_guest_user
    if current_user.email == 'guest@example.com'
      redirect_to mypage_public_users_path, alert: "ゲストユーザーはレビュー投稿できません。会員登録をお願いします。"
    end
  end
end
