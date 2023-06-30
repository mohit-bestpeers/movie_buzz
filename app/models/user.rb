class User < ApplicationRecord

  has_many :reviews , dependent: :destroy
  has_many :movies, through: :reviews , dependent: :destroy
  has_many :movies , dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:user, :admin]

end
