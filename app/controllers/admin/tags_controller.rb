class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @tags = Tag.all
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
