require 'mailgun'

class CommentMailer < ::Devise::Mailer  #< ApplicationMailer
	 default from: Rails.application.secrets.emailer

  def notify_on_comment(user, article)
    @user = user
    authors = article['authors'].join(" ")
    mg_client = Mailgun::Client.new Rails.application.secrets.mailgun_api_key
    message_params = {:from    => Rails.application.secrets.emailer,
                      :to      => @user.email,
                      :subject => "Comment posted on #{article['title']}",
                      :text    => "A comment was posted on #{article['title']} by #{authors}"}
    mg_client.send_message Rails.application.secrets.test_domain, message_params
  end


  def notify_weekly(user)
  end

  def send_newsletter
  end

  def sign_up(user)
  end

  def send_reset_password_instructions
    @user = User.find(current_user.id)
    mg_client = Mailgun::Client.new Rails.application.secrets.mailgun_api_key


  end


end

