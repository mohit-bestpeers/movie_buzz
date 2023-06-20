class RatingChangeInteger < ActiveRecord::Migration[7.0]
  def change
    change_column :movies, :rating, :integer
  end
end
