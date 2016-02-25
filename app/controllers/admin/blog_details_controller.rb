class Admin::BlogDetailsController < Admin::BaseController
	before_action :set_article, only: [:show, :edit, :update]

	def index
		@blog_details = BlogDetail.all
		@create_details = ""
		user = User.find(current_user.id)
		if @blog_details.empty?
			@create_details = 'New'
		end		

		respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @blog_details }
    	end
	end

	def show    
      @blog_details = BlogDetail.find(params[:id])
  	end

	def new
		@blog_details = BlogDetail.new
	end

	def edit
		@blog_details = BlogDetail.find(params[:id])
	end
	
	def create
		@blog_details = BlogDetail.new(blog_params)
		@blog_details[:topics] = params[:blog_detail][:topics].split(",").map{|item| item.strip}
		@blog_details[:social_accounts] = params[:blog_detail][:social_accounts].split(",").map{|item| item.strip}
		respond_to do |format|
	      if @blog_details.save
	        format.html { redirect_to admin_blog_details_path, notice: 'Blog details were added.' }
	        format.json { render :show, status: :created, location: [:admin,@blog_details] }
	      else
	        format.html { render :new }
	        format.json { render json: @blog_details.errors, status: :unprocessable_entity }
	      end
    	end
	end

	def update
		@blog_details = BlogDetail.find(params[:id])
		respond_to do |format|       
	      if @blog_details.update(blog_params)
	      	flash[:notice]= "Blog details for #{@blog_details.author} were successfully updated."
	      	format.html {redirect_to [:admin, @blog_details]}
	        # format.html { redirect_to [:admin, @blog_details], notice: 'Blog details were successfully updated.' }
	        format.json { render :show, status: :ok, location: @blog_details }
	      else
	        format.html { render :edit }
	        format.json { render json: @blog_details.errors, status: :unprocessable_entity }
	      end
	    end
	end

	def destroy
		@blog_details = BlogDetail.find(params[:id])
		@blog_details.destroy
	    respond_to do |format|
	      format.html { redirect_to admin_blog_details_path, notice: "Blogs details for #{@blog_details.author} was successfully deleted." }
	      # format.html { redirect_to admin_articles_url, notice: 'Article was successfully destroyed.' }
	      format.json { head :no_content }
    	end
	end

	def export_to_json
		export_to_json = "mongoexport --db mongoblog_development --collection articles --out articles.json"
		system(export_to_json)
	    redirect_to admin_blog_details_path, notice: "Export Completed" 
	    # format.html { redirect_to admin_articles_url, notice: 'Article was successfully destroyed.' }
	end


	private
	    # Use callbacks to share common setup or constraints between actions.
	    def set_article
	      @blog_details = BlogDetail.find(params[:id])
	    end

	    # Never trust parameters from the scary internet, only allow the white list through.
	    def blog_params
	      params.require(:blog_detail).permit(:blog_title, :blurb, :author, :topics=>[], :social_accounts=>[])
	    end
end


