class ChangeRatingTypeInReviews < ActiveRecord::Migration[6.1]
  def up
    change_column :reviews, :rating, :decimal
  end
  
  def down
    change_column :reviews, :rating, :string
  end
end
