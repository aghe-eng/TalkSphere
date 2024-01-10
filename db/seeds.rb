# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Post.destroy_all
User.destroy_all
Category.destroy_all

# Seed Users
user1 = User.create(username: "ehiaghe", email: "ehiaghe_aisiri@talksphere.com", password: "password123")
user2 = User.create(username: "fabian", email: "fabian_sluga@talksphere.com", password: "password123")
user3 = User.create(username: "excel", email: "excel_isibor@talksphere.com", password: "password123")
user4 = User.create(username: "fred", email: "fred_isibor@talksphere.com", password: "password123")

puts "Users seeded successfully."

# Seed Categories

technology_category = Category.create(name: "Technology")
science_category = Category.create(name: "Science")
travel_category = Category.create(name: "Travel")
politics_category = Category.create(name: "Politics")
parenting_category = Category.create(name: "Parenting")
lifestyle_category = Category.create(name: "Lifestyle")
religion_category = Category.create(name: "Religion")

puts "Categories seeded successfully."

# Seed Posts
Post.create(title: "The Future of Artificial Intelligence", content: "Discussing the advancements in AI.", views: 0, category_id: technology_category.id, user_id: user1.id)
Post.create(title: "Exploring the Cosmos", content: "Journeying through space and time.", views: 0, category_id: science_category.id, user_id: user2.id)
Post.create(title: "Adventures in Southeast Asia", content: "Share your travel stories!", views: 0, category_id: travel_category.id, user_id: user3.id)
Post.create(title: "Political Polarization: Finding Common Ground", content: "In an era of increasing political polarization, how can we bridge the divide and foster constructive dialogue? Share your insights and ideas.", views: 0, category_id: politics_category.id, user_id: user1.id)
Post.create(title: "Navigating the Challenges of Remote Learning with Kids", content: "As parents, many of us have faced unprecedented challenges due to the shift to remote learning. Balancing work, household responsibilities, and supporting our children's education can be overwhelming.", views: 0, category_id: parenting_category.id, user_id: user2.id)
Post.create(title: "Daily Mindfulness Tips", content: "Share your quick mindfulness hacks! Whether it's a 5-minute meditation or a mindful breathing exercise, let's swap ideas on staying present in our fast-paced lives. What's your favorite mindful moment?", views: 0, category_id: lifestyle_category.id, user_id: user3.id)
Post.create(title: "Reflecting on Faith: Sacred Traditions and Personal Journeys", content: "Let's delve into discussions about our diverse religious beliefs. Share your insights on sacred traditions, spiritual practices, and the personal journeys that have shaped your faith.", views: 0, category_id: religion_category.id, user_id: user4.id)

puts "Posts seeded successfully."
