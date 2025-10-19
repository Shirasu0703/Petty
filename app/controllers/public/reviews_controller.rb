class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :reject_guest_user, only: [:new, :create]
  before_action :set_hospital
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @review = current_user.reviews.new
  end

  def show
    @comment = Comment.new
    @hospital = Hospital.find(params[:hospital_id])
    @review = @hospital.reviews.find(params[:id])
    # .page(params[:page]).per(6)
  end

  def index
    @reviews = Review.all.order(params[:id])
  end

  def create
    @review = @hospital.reviews.build(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to public_hospital_path(@hospital), notice: "レビューを投稿しました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to public_hospital_review_path(@hospital, @review), notice: "レビューを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to public_hospitals_path, notice: "レビューを削除しました"
  end

  private

  def set_hospital
    @hospital = Hospital.find(params[:hospital_id])
  end

  def set_review
    @review = @hospital.reviews.find(params[:id])
  end

  def ensure_correct_user
    unless @review.user == current_user
      flash[:alert] = "権限がありません。"
      redirect_to public_hospital_reviews_path
    end
  end
   
  def review_params
    params.require(:review).permit(:title, :body, :image, :rating,
                                   :cleanliness_comment, :doctor_comment, :staff_comment, :price_comment, :waiting_comment, :animal_comment,
                                   :cleanliness_rating, :doctor_rating, :staff_rating, :price_rating, :waiting_rating,
                                   :animal_type, :animal_icon)
  end

  def reject_guest_user
    if current_user.email == 'guest@example.com'
      redirect_to mypage_public_users_path, alert: "ゲストユーザーはレビュー投稿できません。会員登録をお願いします。"
    end
  end
end
