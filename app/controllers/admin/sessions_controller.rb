class Admin::SessionsController < ::Devise::SessionsController

  def create
    user = User.find_by email: params[:user][:email]
    if user && user.valid_password?(params[:user][:password]) && user.has_role?("admin")
      sign_in(:user, user)
      if user.sign_in_count == 1        
        redirect_to edit_user_registration_path, notice: "Please change email and password"
      else
        redirect_to admin_url
      end
      # redirect_to admin_url, notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid / Only Admin is allowed"
      redirect_to :back
    end
  end
end
