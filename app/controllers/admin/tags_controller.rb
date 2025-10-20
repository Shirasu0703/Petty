class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!

  def new
    @tag = Tag.new
  end
  
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
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
  end

  def destroy
  end
end
