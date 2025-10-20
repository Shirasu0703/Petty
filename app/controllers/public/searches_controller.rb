class Public::SearchesController < ApplicationController
  def search
    @data = params[:data]
    @word = params[:word]
    @method = params[:method]
    if @data == "User"
      @users = User.look_for(@word, @method)
    elsif @data == "Review"
      @reviews = Review.look_for(@word, @method)
    elsif @data == "Hospital"
      @hospitals = Hospital.look_for(@word, @method)
    elsif @data == "Tag"
      data = Tag.look_for(@word, @method)
      @hospitals = data[:hospital]
      @reviews = data[:review]
    end
  end
end
