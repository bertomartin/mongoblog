class Admin::RegistrationsController < ::Devise::RegistrationsController

  def edit
    @user = current_user
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
    admin_path
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :email)
  end
end