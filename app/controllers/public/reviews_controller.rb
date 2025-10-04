class Public::ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def show
    @review = Review.find(params[:id])
  end

  def index
    @reviews = Review.all
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to public_review_path(@review.id)
    else
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to public_review_path(@review.id), notice: "投稿情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to mypage_public_users_path, notice: "投稿を削除しました"
  end

  private
   
  def review_params
    params.require(:review).permit(:body, :cleanliness_comment, :doctor_comment, :staff_comment, :price_comment, :waiting_comment, :animal_comment)
  end
end
