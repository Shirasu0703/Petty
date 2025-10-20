class Admin::HospitalsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_hospital, only: [:edit, :update, :destroy]

  def new
    @hospital = Hospital.new
    @tags = Tag.all
  end

  def index
    @hospitals = Hospital.all
  end

  def show
    @hospital = Hospital.find(params[:id])
    @review = @hospital.reviews.first
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

  def create
    @hospital = Hospital.new(hospital_params)
    if @hospital.save
      @hospital.tag_ids = params[:hospital][:tag_ids]
    if params[:hospital][:new_tag_names].present?
      new_tags = params[:hospital][:new_tag_names].split(",").map(&:strip).reject(&:blank?)
      new_tags.each do |tag_name|
        tag = Tag.find_or_create_by(name: tag_name)
        @hospital.tags << tag unless @hospital.tags.include?(tag)
      end
    end
      redirect_to admin_hospitals_path, notice: "病院を登録しました"
    else
      @tags = Tag.all
      render :new
    end
  end

  def edit
  end

  def update
    if @hospital.update(hospital_params)
      redirect_to admin_hospitals_path, notice: "病院情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @hospital = Hospital.find(params[:id])
    @hospital.destroy
    redirect_to admin_hospitals_path, notice: "病院を削除しました"
  end

  def remove_main_image
    @hospital = Hospital.find(params[:id])
    @hospital.main_image.purge
    redirect_to edit_admin_hospital_path(@hospital), notice: "メイン画像を削除しました"
  end
  
  def remove_sub_image
    @hospital = Hospital.find(params[:id])
    image = @hospital.sub_images.find(params[:image_id])
    image.purge
    redirect_to edit_admin_hospital_path(@hospital), notice: "サブ画像を削除しました"
  end

  def remove_tag
    @hospital = Hospital.find(params[:id])
    tag = Tag.find(params[:tag_id])
    @hospital.tags.destroy(tag)
    redirect_to edit_admin_hospital_path(@hospital), notice: "#{tag.tag} を削除しました。"
  end

  def average_rating
    reviews.average(:rating).to_f.round(1)
  end

  private

  def set_hospital
    @hospital = Hospital.find(params[:id])
  end

  def hospital_params
    params.require(:hospital).permit(:name, :address, :phone_number, :opening_hours, :animal_types, :main_image,
                                      sub_images: [], tag_ids: [] )
  end 

  def authenticate_admin!
    redirect_to root_path, alert: "権限がありません" unless current_admin
  end
end
