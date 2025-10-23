class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :reject_guest_user, only: [:new, :create, :update, :destroy]
  before_action :set_hospital, except: [:index]
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @review = current_user.reviews.new
    @tags = Tag.all
  end

  def show
    @comment = Comment.new
    @hospital = Hospital.find(params[:hospital_id])
    @review = @hospital.reviews.find(params[:id])
    # .page(params[:page]).per(6)
  end

  def index
    @reviews = Review.all.order(params[:id])
    # @reviews.params[:tag_id].present? ? Tag.find(params[:tag_id]).reviews : Post.all
    if params[:tag_id].present?
      @tag =Tag.find(params[:tag_id])
      @reviews = @tag.reviews.includes(:user, :hospital)
    else
      @reviews = Review.all.includes(:user, :hospital)
    end
  end

  def create
    @review = @hospital.reviews.build(review_params)
    @review.user_id = current_user.id
    # reviewとtagを紐付け
    if @review.save
      if params[:review][:tag_ids].present?
        @review.tag_ids = params[:review][:tag_ids]
      end
      # タグ作成との紐付け
      if params[:review][:new_tag_names].present?
        new_tags = params[:review][:new_tag_names].split(',').map(&:strip).reject(&:blank?)
        new_tags.each do |tag_name|
          formatted_name = tag_name.start_with?('#') ? tag_name : "##{tag_name}"
          tag = Tag.find_or_create_by(tag: formatted_name)
          @review.tags << tag unless @review.tags.include?(tag)
        end
      end
      redirect_to public_hospital_path(@hospital), notice: "レビューを投稿しました"
    else
      @tags = Tag.all
      render :new
    end
  end

  def edit
    @tags = Tag.all
  end

  def update
    if @review.update(review_params)
      if params[:review][:new_tag_names].present?
        new_tags = params[:review][:new_tag_names].split(',').map(&:strip).reject(&:blank?)
        new_tags.each do |tag_name|
          formatted_name = tag_name.start_with?('#') ? tag_name : "##{tag_name}"
          tag = Tag.find_or_create_by(tag: formatted_name)
          @review.tags << tag unless @review.tags.include?(tag)
        end
      end
      redirect_to public_hospital_review_path(@hospital, @review), notice: "レビューを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to public_hospitals_path, notice: "レビューを削除しました"
  end

  def remove_tag
    @review = Review.find(params[:id])
    tag = Tag.find(params[:tag_id])
    @review.tags.destroy(tag)
    redirect_to edit_public_hospital_review_path(@review.hospital, @review), notice: "#{tag.tag} を削除しました。"
  end

  def add_tag
    @review = Review.find(params[:id])
    tag = Tag.find_or_create_by(tag: params[:tag_name])
    @review.tags << tag unless @review.tags.include?(tag)
    redirect_to edit_public_hospital_review_path(@review.hospital, @review), notice: "#{tag.tag} を追加しました。"
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
                                   :animal_type, :animal_icon, tag_ids: [])
  end

  def reject_guest_user
    if current_user.email == 'guest@example.com'
      redirect_to mypage_public_users_path, alert: "ゲストユーザーはレビュー投稿できません。会員登録をお願いします。"
    end
  end
end
