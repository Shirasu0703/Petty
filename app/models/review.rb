class Review < ApplicationRecord
  belongs_to :user
  belongs_to :hospital
  has_many :review_tags, dependent: :destroy
  has_many :tags, through: :review_tags

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :body, presence: true
  validates :rating, presence: true

  def self.look_for(word, method)
    case method
    when "perfect"
      Review.includes(:review_tags).where("body LIKE ?", "%#{word}%").or(
        Review.includes(:review_tags).where("title LIKE ?", "%#{word}%")
      ).or(
        Review.includes(:review_tags).where(
          'review_tags.tag_id': Tag.includes(:review_tags).where(
            'tags.tag like ?', "%#{word}%"
          ).pluck(:tag_id)
        )
      )

    when "forward"
      Review.includes(:review_tags).where("body LIKE ?", "#{word}%").or(
        Review.includes(:review_tags).where("title LIKE ?", "#{word}%")
      ).or(
        Review.includes(:review_tags).where(
          'review_tags.tag_id': Tag.includes(:review_tags).where(
            'tags.tag like ?', "#{word}%"
          ).pluck(:tag_id)
        )
      )
    when "backward"
      Review.includes(:review_tags).where("body LIKE ?", "%#{word}").or(
        Review.includes(:review_tags).where("title LIKE ?", "%#{word}")
      ).or(
        Review.includes(:review_tags).where(
          'review_tags.tag_id': Tag.includes(:review_tags).where(
            'tags.tag like ?', "%#{word}"
          ).pluck(:tag_id)
        )
      )
    when "partial"
      Review.includes(:review_tags).where("body LIKE ?", "%#{word}%").or(
        Review.includes(:review_tags).where("title LIKE ?", "%#{word}%")
      ).or(
        Review.includes(:review_tags).where(
          'review_tags.tag_id': Tag.includes(:review_tags).where(
            'tags.tag like ?', "%#{word}%"
          ).pluck(:tag_id)
        )
      )
    else
      Revview.all
    end
  end
end
