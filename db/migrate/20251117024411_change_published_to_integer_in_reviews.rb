class ChangePublishedToIntegerInReviews < ActiveRecord::Migration[6.1]
  def change
    change_column :reviews, :published, :integer, default: 0, using: 'published::integer'
  end
end
