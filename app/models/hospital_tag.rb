class HospitalTag < ApplicationRecord
  belongs_to :hospital
  belongs_to :tag
end
