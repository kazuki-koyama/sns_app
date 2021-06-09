class Post < ApplicationRecord

  belongs_to :user
  has_many :likes, dependent: :destroy

  attachment :before_image
  attachment :after_image

  validates :before_image, presence: true
  validates :after_image, presence: true
  validates :caption, length: { maximum: 300 }

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
