class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_rich_text :content
  has_many :likes, as: :likable
  after_create_commit :notify_recipient
  has_noticed_notifications model_name: 'Notification'
  before_destroy :cleanup_notifcations

  validates :content, presence: true, length: {minimum: 5, maximum: 200}

  def notify_recipient
    NewCommentNotifier.with(recipient: post.user, actor: user, resource: self).deliver_later(post.user)
  end

  def cleanup_notifcations
    Noticed::Event.where("params -> 'recipient' = ? AND params -> 'actor' = ? AND params -> 'resource' = ?", post.user.to_json, user.to_json, self.to_json).destroy_all
  end
end
