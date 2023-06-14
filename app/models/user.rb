class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_initialize do
    if self.new_record?
      self.role ||= :user
    end
  end
 
  has_many :reviews 
  has_many :movies, through: :reviews
  has_many :movies

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:admin, :user]

end
