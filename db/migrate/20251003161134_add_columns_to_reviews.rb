class AddColumnsToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :cleanliness_rating, :decimal, precision: 2, scale: 1, null: false
    add_column :reviews, :cleanliness_comment, :string
    add_column :reviews, :doctor_rating, :decimal, precision: 2, scale: 1, null: false
    add_column :reviews, :doctor_comment, :string
    add_column :reviews, :staff_rating, :decimal, precision: 2, scale: 1, null: false
    add_column :reviews, :staff_comment, :string
    add_column :reviews, :price_rating, :decimal, precision: 2, scale: 1, null: false
    add_column :reviews, :price_comment, :string
    add_column :reviews, :waiting_rating, :decimal, precision: 2, scale: 1, null: false
    add_column :reviews, :waiting_comment, :string
    add_column :reviews, :animal_comment, :string
    add_column :reviews, :animal_type, :string
    add_column :reviews, :animal_icon, :string
  end
end
