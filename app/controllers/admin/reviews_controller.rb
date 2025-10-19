class Admin::ReviewsController < ApplicationController
before_action :authenticate_admin!
  def show
    @hospital = Hospital.find(params[:hospital_id])
    @review = @hospital.reviews.find(params[:id])
    @comment = Comment.new
  end

  def index
    @reviews = Review.all
  end

  def create
    @hospital = Hospital.find(params[:hospital_id])
    @review = @hospital.reviews.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to admin_review_path(@hospital), notice: "レビューを投稿しました"
    else
      render :new
    end
  end

  def edit
    @hospital = Hospital.find(params[:hospital_id])
    @review = @hospital.reviews.find(params[:id])
  end

  def update
    @hospital = Hospital.find(params[:hospital_id])
    @review = @hospital.reviews.find(params[:id])
    if @review.update(review_params)
      redirect_to admin_hospital_review_path(@hospital, @review), notice: "レビューを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @hospital = Hospital.find(params[:hospital_id])
    @review = @hospital.reviews.find(params[:id])
    @review.destroy
    redirect_to admin_hospital_path(@hospital), notice: "レビューを削除しました"
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :image, :rating,
                                   :cleanliness_comment, :doctor_comment, :staff_comment, :price_comment, :waiting_comment, :animal_comment,
                                   :cleanliness_rating, :doctor_rating, :staff_rating, :price_rating, :waiting_rating,
                                   :animal_type, :animal_icon)
  end
end
