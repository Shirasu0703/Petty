class Public::TagsController < ApplicationController
  before_action :reject_guest_user, only: [:create, :destroy]
  def index
    if params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @reviews = @tag.reviews.includes(:hospital)
      @hospital = Hospital.find_by(id: params[:hospital_id]) if params[:hospital_id].present?
    else
      @reviews = Review.includes(:hospital, :tags).all
    end
  end

  def show
    @tag = Tag.find(params[:id])
    @hospitals = @tag.hospitals
    @reviews = @tag.reviews
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to public_tags_path, notice: "タグを追加しました。"
    else
      redirect_to public_tags_path, notice: "タグの追加に失敗しました。"
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    if @tag.destroy
      redirect_to public_tags_path, notice: "#{@tag.tag}を削除しました。"
    else
      redirect_to public_tags_path, alert: "指定されたタグが見つかりません。"
    end
  end
end
