class Admin::BaseController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  before_filter :is_admin?


  private

  def is_admin?
    return current_user.has_role? "admin"
  end

end
