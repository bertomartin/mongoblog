class Admin::BaseController < ApplicationController
  layout 'admin'
  # before_filter :require_admin_user
  before_filter :authenticate_user!

  private

  def require_admin_user
    if current_user
      if current_user.has_role? "admin"
       return true
     end
    else
      return false
    end

  end

end
