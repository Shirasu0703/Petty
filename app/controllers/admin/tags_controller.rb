class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @tags = Tag.all
    @hospital = Hospital.find_by(id: params[:hospital_id]) if params[:hospital_id].present?
  end

  def show
    @tag = Tag.find(params[:id])
    @hospitals = @tag.hospitals
    @reviews = @tag.reviews
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to admin_tags_path, notice: "タグを追加しました。"
    else
      redirect_to admin_tags_path, notice: "タグの追加に失敗しました。"
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
  end

  def destroy
    @tag = Tag.find_by(params[:id])
    if @tag.destroy
      redirect_to admin_tags_path, notice: "#{@tag.tag}を削除しました。"
    else
      redirect_to admin_tags_path, alert: "指定されたタグが見つかりません。"
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:tag)
  end
end
