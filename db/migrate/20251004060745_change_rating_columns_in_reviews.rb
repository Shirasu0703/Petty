class ChangeRatingColumnsInReviews < ActiveRecord::Migration[6.1]
  def change
    change_column_null :reviews, :title, true

    change_column_null :reviews, :rating, true

    change_column_null :reviews, :cleanliness_rating, true

    change_column_null :reviews, :doctor_rating, true

    change_column_null :reviews, :staff_rating, true

    change_column_null :reviews, :price_rating, true

    change_column_null :reviews, :waiting_rating, true

    change_column_null :reviews, :hospital_id, true

  end
end
