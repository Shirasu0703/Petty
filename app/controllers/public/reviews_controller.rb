class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  def new
    @review = current_user.reviews.new
  end

  def show
    @review = Review.find(params[:id])
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
    @review = current_user.reviews.find(params[:id])
  end

  def update
    @review = current_user.reviews.find(params[:id])
    if @review.update(review_params)
      redirect_to public_review_path(@review.id), notice: "レビューを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @review = current_user.reviews.find(params[:id])
    @review.destroy
    redirect_to mypage_public_users_path, notice: "レビューを削除しました"
  end

  private
   
  def review_params
    params.require(:review).permit(:title, :body, :image, :cleanliness_comment, :doctor_comment, :staff_comment, :price_comment, :waiting_comment, :animal_comment)
  end
end
