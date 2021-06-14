class Hashtag < ApplicationRecord
  validates :hashname, presence: true, length: { maximum: 50 }
  has_many :hashtag_posts, dependent: :destroy
  has_many :posts, through: :hashtag_posts

  def self.search(keyword)
    if keyword != '#'
      hashtag = Hashtag.where(hashname: keyword.downcase.delete('#'))
      return none if hashtag[0].nil?
      # 部分一致検索の場合
      # hashtag = Hashtag.where('hashname LIKE(?)' , "%#{keyword.downcase.delete('#')}%")
      hashtag[0].posts
    end
  end
end
