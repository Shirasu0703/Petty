class Admin::HospitalsController < ApplicationController
  before_action :set_hospital, only: [:edit, :update, :destroy]

  def new
    @hospital = Hospital.new
  end

  def index
    @hospitals = Hospital.all
  end

  def show
    @hospital = Hospital.find(params[:id])
  end

  def create
    @hospital = Hospital.new(hospital_params)
    if @hospital.save
      redirect_to admin_hospitals_path, notice: "病院を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @hospital.update(hospital_params)
      redirect_to admin_hospitals_path, notice: "病院情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
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

  private

  def set_hospital
    @hospital = Hospital.find(params[:id])
  end

  def hospital_params
    params.require(:hospital).permit(:name, :address, :phone_number, :opening_hours, :animal_types, :main_image, sub_images: [] )
  end 

  def authenticate_admin!
    redirect_to root_path, alert: "権限がありません" unless current_user&.admin?
  end
end
