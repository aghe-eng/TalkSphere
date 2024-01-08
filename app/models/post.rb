class Post < ApplicationRecord
  belongs_to :user_id
  belongs_to :category_id
end
