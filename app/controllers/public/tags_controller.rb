class Public::TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def show
    @tag = Tag.find(params[:id])
    @hospitals = @tag.hospitals
    @reviews = @tag.reviews
  end

  def create
  end

  def destroy
  end
end
