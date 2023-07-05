class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  validates :user_id, uniqueness: {scope: :movie_id}
  after_save :update_movie_average_rating
  after_destroy :update_movie_average_rating

  private

  def update_movie_average_rating
    movie.update_average_rating
  end
end
