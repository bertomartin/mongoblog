class Admin::ProfilesController < Admin::BaseController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def show
    
  end

  def new
    current_user.profile = {}
  end

  def create
  end

  def edit
  end

  def update
    current_user.profile = profile_params
    respond_to do |format|
      if current_user.save
        format.html {redirect_to admin_profile_path, notice: 'Comment was successfully created.'}
      else
        format.html { redirect_to new_admin_profile_path }
      end
    end
  end

  def delete
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_params
    # byebug
    params.require(:profile).permit(:first_name, :last_name)
  end


end