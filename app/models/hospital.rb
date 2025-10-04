class Hospital < ApplicationRecord

  has_many :reviews, dependent: :destroy
end
