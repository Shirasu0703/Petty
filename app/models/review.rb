class Review < ApplicationRecord
  belongs_to :user
  belongs_to :hospital

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :body, presence: true
  # validates :rating, presence: true

  def self.look_for(word, method)
    if method == "perfect"
      @review = Review.where("reviews.title LIKE ?", "#{word}")
    elsif method == "forward"
      @review = Review.where("reviews.title LIKE ?", "#{word}%")
    elsif method == "backward"
      @review = Review.where("reviews.title LIKE ?", "%#{word}")
    elsif method == "partial"
      @review = Review.where("reviews.title LIKE ?", "%#{word}%")
    end
  end
end
