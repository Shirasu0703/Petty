class Admin::HospitalsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_hospital, only: [:edit, :update, :destroy]

  def new
    @hosptal = Hospital.new
  end

  def index
    @hospitals = Hospital.all
  end

  def show
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

  private

  def set_hospital
    @hospital = Hospital.find(params[:id])
  end

  def hospitao_params
    params.requre(:hospital).permit(:name, :address, :phone_number, :opening_hours, :animal_types)
  end 

  def authenticate_admin!
    redirect_to root_path, alert: "権限がありません" unless current_user&.admin?
  end
end
