class Public::HospitalsController < ApplicationController

  def index
    @hospitals = Hospital.all

    case params[:sort]
    when 'created_at DESC'
      @hospitals = @hospitals.order(created_at: :desc)
    when 'star DESC'
      @hospitals = @hospitals
        .left_joins(:reviews)
        .group('hospitals.id')
        # 平均点が高い順
        .order(Arel.sql'AVG(reviews.rating) DESC')
    else
      @hospitals = @hospitals.order(created_at: :desc)
    end
  end

  def show
    @hospital = Hospital.find(params[:id])
    @comment = Comment.new
    allowed_sorts = {
       'new' => { created_at: :desc },
      'high_rating' => { rating: :desc }
     }
    sort_key = params[:sort] || "new"
    sort_order = allowed_sorts[sort_key] || { created_at: :desc }
    # ログインユーザーの投稿したレビューを新しい順に取得とページネーション
     @reviews = @hospital.reviews.order(sort_order)
  end
end
