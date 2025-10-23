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
      redirect_to admin_tags_path, notice: "すでに登録されています。"
    end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      @tags = Tag.all
      redirect_to admin_tags_path, notice: "#{@tag.tag}へ更新しました。"
    else
      redirect_to edit_admin_tag_path(@tag), alert: "更新に失敗しました。"
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
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
