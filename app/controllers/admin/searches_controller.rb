class Admin::SearchesController < ApplicationController
before_action :authenticate_admin!
  def search
    @reviews = []
    @data = params[:data]
    @word = params[:word]
    @method = params[:method]
    if @data == "User"
      @users = User.look_for(@word, @method)
    else
      @reviews = Review.look_for(@word, @method)
    end
  end
end
