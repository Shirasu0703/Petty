class AddPublishedToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :published, :boolean, default: true, null: false
  end
end
