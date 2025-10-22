class Public::ReviewTagsController < ApplicationController
  before_action :reject_guest_user, only: [:create, :destroy]
  def create
  end

  def destroy
  end
end
