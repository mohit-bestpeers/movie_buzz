class RemoveReviewableIdFromReviews < ActiveRecord::Migration[7.0]
  def change
    remove_column :reviews, :reviewable_id
    remove_column :reviews, :reviewable_type
  end
end
