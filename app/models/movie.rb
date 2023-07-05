class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews , dependent: :destroy
  belongs_to :user 
  belongs_to :category
  has_one_attached :image

  validates :name, presence: true
  validates :released_on, presence: true

  def update_average_rating
    self.rating = reviews.average(:star)&.round(1)
    save
  end

end
