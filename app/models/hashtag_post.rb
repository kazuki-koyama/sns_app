class HashtagPost < ApplicationRecord
  belongs_to :post
  belongs_to :hashtag
  validate :post_id, presence: true
  validate :hashtag_id, presence: true
end
