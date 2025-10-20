class Tag < ApplicationRecord
  has_many :hospital_tags, dependent: :destroy
  has_many :hospitals, through: :hospital_tags
  
  has_many :review_tags, dependent: :destroy
  has_many :reviews, through: :review_tags

  def self.look_for(word, method)
    if method == "perfect"
      {
        hospital: Hospital.includes(:hospital_tags).where(
          'hospital_tags.tag_id': Tag.includes(:hospital_tags).where(
            'tags.tag like ?', "#{word}"
          ).pluck(:tag_id)
        ),
        review: Review.includes(:review_tags).where(
          'review_tags.tag_id': Tag.includes(:review_tags).where(
            'tags.tag like ?', "#{word}"
          ).pluck(:tag_id)
        )
      }
    elsif method == "forward"
      {
        hospital: Hospital.includes(:hospital_tags).where(
          'hospital_tags.tag_id': Tag.includes(:hospital_tags).where(
            'tags.tag like ?', "#{word}%"
          ).pluck(:tag_id)
        ),
        review: Review.includes(:review_tags).where(
          'review_tags.tag_id': Tag.includes(:review_tags).where(
            'tags.tag like ?', "#{word}%"
          ).pluck(:tag_id)
        )
      }
    elsif method == "backward"
      {
        hospital: Hospital.includes(:hospital_tags).where(
          'hospital_tags.tag_id': Tag.includes(:hospital_tags).where(
            'tags.tag like ?', "#%{word}"
          ).pluck(:tag_id)
        ),
        review: Review.includes(:review_tags).where(
          'review_tags.tag_id': Tag.includes(:review_tags).where(
            'tags.tag like ?', "#%{word}"
          ).pluck(:tag_id)
        )
      }
    elsif method == "partial"
      {
        hospital: Hospital.includes(:hospital_tags).where(
          'hospital_tags.tag_id': Tag.includes(:hospital_tags).where(
            'tags.tag like ?', "%#{word}%"
          ).pluck(:tag_id)
        ),
        review: Review.includes(:review_tags).where(
          'review_tags.tag_id': Tag.includes(:review_tags).where(
            'tags.tag like ?', "%#{word}%"
          ).pluck(:tag_id)
        )
      }
    end
  end
end
