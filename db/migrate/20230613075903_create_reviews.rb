class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.string :body
      t.integer :star
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
