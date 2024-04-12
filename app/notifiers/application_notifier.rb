# app/notifiers/application_notifier.rb
class ApplicationNotifier < Noticed::Base
  deliver_by :database
  deliver_by :email, mailer: 'ApplicationMailer'
end
