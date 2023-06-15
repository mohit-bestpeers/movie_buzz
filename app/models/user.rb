class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # after_initialize do
  #   if self.new_record?
  #     self.role ||= :admin
  #   end
  # end
 
  has_many :reviews , dependent: :destroy
  has_many :movies, through: :reviews
  has_many :movies , dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:user,:admin]

end
