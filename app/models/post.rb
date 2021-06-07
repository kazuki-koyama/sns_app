class Post < ApplicationRecord

  belongs_to :user

  attachment :before_image
  attachment :after_image

  validates :before_image, presence: true
  validates :after_image, presence: true
  validates :caption, length: { maximum: 300 }
end
