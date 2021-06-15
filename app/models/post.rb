class Post < ApplicationRecord
  belongs_to :user
  has_many :likes,         dependent: :destroy
  has_many :comments,      dependent: :destroy
  has_many :favorites,     dependent: :destroy
  has_many :hashtag_posts, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :hashtags, through: :hashtag_posts

  attachment :before_image
  attachment :after_image

  validates :before_image, presence: true
  validates :after_image, presence: true
  validates :caption, length: { maximum: 300 }

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  after_create do
    post = Post.find_by(id: id)
    hashtags = caption.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      post.hashtags << tag
    end
  end

  before_update do
    post = Post.find_by(id: id)
    post.hashtags.clear
    hashtags = caption.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      post.hashtags << tag
    end
  end
end
