class Admin::SessionsController < ::Devise::SessionsController

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
    end
  end
end
