class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_rich_text :content
  has_many :likes, as: :likable

  validates :content, presence: true, length: {minimum: 10, maximum: 200}
end
