class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :name
      t.string :rating
      t.text :description
      t.date :released_on

      t.timestamps
    end
  end
end
