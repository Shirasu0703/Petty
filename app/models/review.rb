class Review < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # has_one_attached :image

  validates :body, presence: true
  # validates :rating, presence: true
end
