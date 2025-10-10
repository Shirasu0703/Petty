class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @review = current_user.reviews.new
  end

  def show
  end

  def index
    @reviews = Review.all
  end

  def create
    @review = current_user.reviews.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to public_review_path(@review.id), notice: "レビューを投稿しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to public_review_path(@review.id), notice: "レビューを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to mypage_public_users_path, notice: "レビューを削除しました"
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def ensure_correct_user
    unless @review.user == current_user
      flash[:alert] = "権限がありません。"
      redirect_to public_reviews_path
    end
  end
   
  def review_params
    params.require(:review).permit(:title, :body, :image, :cleanliness_comment, :doctor_comment, :staff_comment, :price_comment, :waiting_comment, :animal_comment)
  end
end
