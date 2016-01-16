class Admin::SessionsController < ::Devise::SessionsController

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password]) && user.has_role? "admin"
      session[:user_id] = user.id
      redirect_to admin_url, notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid / Only Admin is allowed"
    end
  end
end
