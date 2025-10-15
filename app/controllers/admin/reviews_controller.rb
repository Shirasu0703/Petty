class Admin::ReviewsController < ApplicationController
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
    @review = Review.find(params[:id])
  end

  def update
    @hospital = Hospital.find(params[:hospital_id])
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to admin_hospital_path(@hospital), notice: "レビューを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @hospital = Hospital.find(params[:hospital_id])
    @review = @hospital.reviews.find(params[:id])
    @review.destroy
    redirect_to admin_hospitals_path, notice: "レビューを削除しました"
  end

  private

  def review_params
    params.require(:review).permit(:title, :body, :image, :cleanliness_comment, :doctor_comment, :staff_comment, :price_comment, :waiting_comment, :animal_comment)
  end

end
