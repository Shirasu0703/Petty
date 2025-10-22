class AddReviewIdToReviewTags < ActiveRecord::Migration[6.1]
  def change
    add_reference :review_tags, :review, null: false, foreign_key: true
  end
end
