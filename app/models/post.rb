class Post < ApplicationRecord
  validates :title, presence: true, length: {minimum: 5, maximum: 50}
  validates :content, presence: true, length: {minimum: 20, maximum: 500}
end
