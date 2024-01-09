class Post < ApplicationRecord
  validates :title, presence: true, length: {minimium: 5, maximium: 50}
  validates :content, presence: true, length: {minimium: 50, maximium: 500}
end
