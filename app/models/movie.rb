class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews , dependent: :destroy
  belongs_to :user 
  has_one_attached :image

  def update_average_rating
    self.rating = reviews.average(:star)
    save
  end

end
