class Admin::ReviewsController < ApplicationController
before_action :authenticate_admin!
before_action :set_hospital, only: [:show, :create, :edit, :update,:destroy]
before_action :set_review_for_hospital, only: [:show, :edit, :update, :destroy]

  def show
    unless @review
      @review = Review.find(params[:id])
      @hospital = @review.hospital
    end
    @comment = Comment.new
  end

  def index
    # @reviews = Review.all.order(params[:id])
    @reviews = Review.all.order(:id)
    # @reviews.params[:tag_id].present? ? Tag.find(params[:tag_id]).reviews : Post.all
    if params[:tag_id].present?
      @reviews = Review.joins(:tags).where(tags: { id: params[:tag_id] }).distinct
    else
      @reviews = Review.all
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
      redirect_to admin_hospital_path(@hospital), notice: "レビューを投稿しました"
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
    redirect_to admin_hospital_path(@hospital), notice: "レビューを削除しました"
  end

  private

  def set_hospital
    @hospital = Hospital.find_by(id: params[:hospital_id]) if params[:hospital_id].present?
  end

  def set_review_for_hospital
    if @hospital && params[:id].present?
      @review = @hospital.reviews.find_by(id: params[:id])
    end
  end

  def review_params
    params.require(:review).permit(:title, :body, :image, :rating,
                                   :cleanliness_comment, :doctor_comment, :staff_comment, :price_comment, :waiting_comment, :animal_comment,
                                   :cleanliness_rating, :doctor_rating, :staff_rating, :price_rating, :waiting_rating,
                                   :animal_type, :animal_icon, tag_ids: [])
  end
end
