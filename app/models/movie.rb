class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews , dependent: :destroy
  belongs_to :user 
  has_one_attached :image
end
