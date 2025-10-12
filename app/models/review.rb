class Review < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # has_one_attached :image

  validates :body, presence: true
  # validates :rating, presence: true

  def self.look_for(word, method)
    if method == "perfect"
      @review = ReviewTag.where("title LIKE ?", "#{word}")
    elsif method == "forward"
      @review = Review.where("title LIKE ?", "#{word}%")
    elsif method == "backward"
      @review = Review.where("title LIKE ?", "%#{word}")
    elsif method == "partial"
      @review = Review.where("title LIKE ?", "%#{word}%")
    end
  end
end
