class Public::CommentsController < ApplicationController
  def create
    @hospital = Hospital.find(params[:hospital_id])
    @review = Review.find(params[:review_id])
    @comment = current_user.comments.new(comment_params)
    @comment.review = @review
    if @comment.save
    redirect_to public_hospital_review_path(@hospital, @review), notice: "コメントを投稿しました"
    else
    redirect_to public_hospital_review_path(@hospital, @review), alert: "コメントの投稿に失敗しました"
    end
  end

  def destroy
    @hospital = Hospital.find(params[:hospital_id])
    @review = @hospital.reviews.find(params[:review_id])
    @comment = @review.comments.find(params[:id])
    @comment.destroy
    redirect_to public_hospital_review_path(@hospital, @review), notice: "コメントを削除しました。"
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
