class Public::HospitalsController < ApplicationController
  def new
  end

  def index
    @hospitals = Hospital.all
  end

  def show
  end

  def create
  end

  def update
  end
end
