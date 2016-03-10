class Admin::SettingsController < Admin::BaseController
	def index
		@user = User.find(current_user.id)
		@settings = @user.setting.all
		if @settings.blank?
		   render 'new'
		else
			@settings = @user.setting[0]
			redirect_to edit_admin_setting_path(@settings)
		end
	end

	def show
		@user = User.find(current_user.id)
		@settings = @user.setting[0].find(params[:id])
	end

	def new
		@settings = Setting.new		
	end

	def edit
		# byebug
		@settings = Setting.find(params[:id])
	end

	def create
		@user = User.find(current_user.id)
		@settings = @user.setting.new(settings_params)
		@settings.save
		redirect_to admin_articles_path
	end


	def update
		@user = User.find(current_user.id)		
		@settings = @user.setting.find_by(settings_params[:id])
		@settings.update(settings_params)
		redirect_to admin_settings_path, notice: 'Settings has been updated.'
	end

	# def change_settings
	# 	@settings = settings_params
	# 	@settings.update(settings_params)
	# 	redirect_to admin_settings_path(@settings), notice: 'Settings has been updated.'
	# 	# else
	# 		# format.html
	# 	# end
	# 	# @settings = Settings.new(settings_params)
	# 	# @user.settings.save
	# 	# format.html { redirect_to admin_settings_path, notice: 'New settings has been created.' }
 #        # format.json { render :show, status: :created, location: [:admin,@settings] }
	# end

	 private

	 def settings_params
	    params.require(:settings).permit!
	 end

end


	# def respond
	# 	@user = User.new(user_params)
	# 	@user.save
	# end