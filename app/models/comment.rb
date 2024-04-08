class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_rich_text :content
  has_many :likes, as: :likable
  after_create_commit :notify_recipient
  before_destroy :cleanup_notifcations
  has_noticed_notifications model_name: 'Notification'

  validates :content, presence: true, length: {minimum: 5, maximum: 200}

  def notify_recipient
    NewCommentNotifier.with(recipient: post.user, actor: user, resource: self).deliver_later
  end

  def cleanup_notifcations
    NewCommentNotifier.where("params -> 'recipient' = ?", post.user.id).destroy_all
  end
end
