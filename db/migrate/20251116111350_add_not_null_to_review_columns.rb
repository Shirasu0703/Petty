class AddNotNullToReviewColumns < ActiveRecord::Migration[6.1]
  def change
    change_column_null :reviews, :title, false
  end
end
