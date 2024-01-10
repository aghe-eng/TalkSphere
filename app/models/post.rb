class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :title, presence: true, length: {minimum: 5, maximum: 100}
  validates :content, presence: true, length: {minimum: 20, maximum: 500}
end
