class Hospital < ApplicationRecord
  has_one_attached :main_image
  has_many_attached :sub_images
  has_many :reviews, dependent: :destroy

  has_many :hospital_tags, dependent: :destroy
  has_many :tags, through: :hospital_tags
  accepts_nested_attributes_for :tags

  validates :name, presence: true
  validates  :address, presence: true
  validates :phone_number, presence: true
  validates :main_image, presence: true

  # 星評価の平均値を算出
  def average_rating
    reviews.average(:rating).to_f.round(1)
  end

  def average_cleanliness
    reviews.average(:cleanliness_rating).to_f.round(1)
  end

  def average_doctor
    reviews.average(:doctor_rating).to_f.round(1)
  end

  def average_staff
    reviews.average(:staff_rating).to_f.round(1)
  end

  def average_price
    reviews.average(:price_rating).to_f.round(1)
  end

  def average_waiting
    reviews.average(:waiting_rating).to_f.round(1)
  end
  
  def self.look_for(word, method)
    case method
    when "perfect"
      Hospital.includes(:hospital_tags).where("name LIKE ?", "#{word}").or(
        Hospital.includes(:hospital_tags).where(
          'hospital_tags.tag_id': Tag.includes(:hospital_tags).where(
            'tags.tag like ?', "#{word}"
          ).pluck(:tag_id)
        )
      )
    when "forward"
      Hospital.includes(:hospital_tags).where("name LIKE ?", "#{word}%").or(
        Hospital.includes(:hospital_tags).where(
          'hospital_tags.tag_id': Tag.includes(:hospital_tags).where(
            'tags.tag like ?', "#{word}%"
          ).pluck(:tag_id)
        )
      )
    when "backward"
      Hospital.includes(:hospital_tags).where("name LIKE ?", "#%{word}").or(
        Hospital.includes(:hospital_tags).where(
          'hospital_tags.tag_id': Tag.includes(:hospital_tags).where(
            'tags.tag like ?', "#%{word}"
          ).pluck(:tag_id)
        )
      )
    when "partial"
      Hospital.includes(:hospital_tags).where("name LIKE ?", "%#{word}%").or(
        Hospital.includes(:hospital_tags).where(
          'hospital_tags.tag_id': Tag.includes(:hospital_tags).where(
            'tags.tag like ?', "%#{word}%"
          ).pluck(:tag_id)
        )
      )
    else
      Hospital.all
    end
  end
end
