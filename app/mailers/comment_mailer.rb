require 'mailgun'

class CommentMailer < ApplicationMailer
	 default from: Rails.application.secrets.emailer

  def notify_on_comment(user)
    @user = user
    mg_client = Mailgun::Client.new Rails.application.secrets.mailgun_api_key
    message_params = {:from    => Rails.application.secrets.emailer,
                      :to      => @user.email,
                      :subject => 'Sample Mail using Mailgun API',
                      :text    => 'This mail is sent using Mailgun API via mailgun-ruby'}
    mg_client.send_message Rails.application.secrets.test_domain, message_params
  end
end
