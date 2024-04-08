class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy
  has_noticed_notifications model_name: 'Notification', mailer: 'NotificationMailer'
  has_many :notifications, through: :user, dependent: :destroy

  validates :title, presence: true, length: {minimum: 5, maximum: 100}
  validates :content, presence: true, length: {minimum: 20, maximum: 1000}
end
