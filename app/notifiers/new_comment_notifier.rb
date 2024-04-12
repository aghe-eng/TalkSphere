# To deliver this notification:
#
# NewCommentNotifier.with(record: @post, message: "New post").deliver(User.all)

class NewCommentNotifier < ApplicationNotifier
  # Add your delivery methods
  deliver_by :database, format: :to_database
  def to_database
    {
      recipient: params[:recipient],
      actor: params[:actor],
      resource: params[:resource]
    }
  end
  #
  # deliver_by :email do |config|
  #   config.mailer = "UserMailer"
  #   config.method = "new_post"
  # end
  #
  # bulk_deliver_by :slack do |config|
  #   config.url = -> { Rails.application.credentials.slack_webhook_url }
  # end
  #
  # deliver_by :custom do |config|
  #   config.class = "MyDeliveryMethod"
  # end

  # Add required params
  #
  # required_param :message
end
