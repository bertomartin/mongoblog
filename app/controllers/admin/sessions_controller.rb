class Admin::SessionsController < ::Devise::SessionsController

  def create
    user = User.find_by email: params[:user][:email]
    if user && user.valid_password?(params[:user][:password]) && user.has_role?("admin")
      # session[:user_id] = user.id
      sign_in(:user, user)
      redirect_to admin_url, notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid / Only Admin is allowed"
    end
  end
end
