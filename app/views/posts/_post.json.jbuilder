json.extract! post, :id, :title, :content, :user_id_id, :category_id_id, :created_at, :updated_at
json.url post_url(post, format: :json)
