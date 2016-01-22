class Admin::SessionsController < ::Devise::SessionsController

<<<<<<< HEAD
  def create 
    user = User.find_by email: params[:user][:email]
    
    if user && user.valid_password?(params[:user][:password])
      user.add_role "admin"
    end

    if user && user.valid_password?(params[:user][:password]) && user.has_role?("admin")      
      sign_in(:user, user)
      redirect_to admin_url, notice: "Logged in!"
    else     
      redirect_to(user_session_url, :notice => "Email or password is invalid / Only Admin is allowed") 
=======
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
>>>>>>> f439a9e2472cba0decf89ddaa535c1fbf18c4cbb
    end
  end
end
