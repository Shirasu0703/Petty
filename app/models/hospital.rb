class Hospital < ApplicationRecord

  has_many :reviews, dependent: :destroy
    # has_one_attached :image
end
