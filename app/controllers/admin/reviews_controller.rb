class Admin::ReviewsController < ApplicationController
before_action :authenticate_admin!
before_action :set_hospital, only: [:show, :create, :edit, :update,:destroy]
before_action :set_review_for_hospital, only: [:show, :edit, :update, :destroy]

  def show
    @review = Review.includes(:favorites).find(params[:id])
    unless @review
      @review = Review.find(params[:id])
      @hospital = @review.hospital
    end
    @comment = Comment.new
  end

  def index
    @reviews = Review.includes(:favorites).all
    @reviews = Review.all.order(:id)
    if params[:tag_id].present?
      @reviews = Review.joins(:tags).where(tags: { id: params[:tag_id] }).distinct
    else
      @reviews = Review.all
    end
    case params[:sort]
    when 'created_at DESC'
      @reviews = @reviews.order(created_at: :desc)
    when 'star DESC'
      @reviews = @reviews.order(rating: :desc)
    when 'favorites DESC'
      @reviews = @reviews
        .left_joins(:favorites)
        .group(:id)
        .order('COUNT(favorites.id) DESC')
    else
      @reviews = @reviews.order(created_at: :desc)
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
    @review = Review.find(params[:id])
    @hospital = @review.hospital
    if @review.update(review_params)
      if params[:review][:new_tag_names].present?
        new_tags = params[:review][:new_tag_names].split(',').map(&:strip).reject(&:blank?)
        new_tags.each do |tag_name|
          formatted_name = tag_name.start_with?('#') ? tag_name : "##{tag_name}"
          tag = Tag.find_or_create_by(tag: formatted_name)
          @review.tags << tag unless @review.tags.include?(tag)
        end
      end
      redirect_to admin_hospital_review_path(@hospital, @review), notice: "レビューを更新しました"
    else
      @tags = Tag.all
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to admin_hospital_path(@hospital), notice: "レビューを削除しました"
  end

  def remove_tag
    @review = Review.find(params[:id])
    tag = Tag.find(params[:tag_id])
    @review.tags.destroy(tag)
    redirect_to edit_admin_hospital_review_path(@review.hospital, @review), notice: "#{tag.tag} を削除しました。"
  end

  def add_tag
    @review = Review.find(params[:id])
    tag = Tag.find_or_create_by(tag: params[:tag_name])
    @review.tags << tag unless @review.tags.include?(tag)
    redirect_to edit_admin_hospital_review_path(@review.hospital, @review), notice: "#{tag.tag} を追加しました。"
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
