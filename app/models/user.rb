class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts,    dependent: :destroy
  has_many :likes,    dependent: :destroy
  has_many :comments, dependent: :destroy

  attachment :profile_image, destroy: false

  validates :name, length: { minimum: 2, maximum: 25 }, uniqueness: true
  validates :introduction, length: { maximum: 140 }
end
