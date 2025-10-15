class Hospital < ApplicationRecord
  has_one_attached :main_image
  has_many_attached :sub_images
  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates  :address, presence: true
  validates :phone_number, presence: true
  validates :main_image, presence: true

end
