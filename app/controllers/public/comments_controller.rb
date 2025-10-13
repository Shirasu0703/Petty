class Public::CommentsController < ApplicationController
  def create
    review = Review.find(params[:review_id])
    comment = current_user.comments.new(comment_params)
    comment.review_id = review.id
    if comment.save
    redirect_to public_review_path(review), notice: "コメントを投稿しました"
    else
    redirect_to public_review_path(review), alert: "コメントの投稿に失敗しました"
    end
  end

  def destroy
    review = Review.find(params[:review_id])
    comment = review.comments.find(params[:id])
    comment.destroy
    redirect_to public_review_path(review), notice: "コメントを削除しました。"
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
