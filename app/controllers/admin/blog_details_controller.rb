class Admin::BlogDetailsController < Admin::BaseController
	def index
		@blog_details = BlogDetail.all

		respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @blog_details }
    	end
	end

	def show    
    	# @comment = @article.comments.build
  	end

	def new
		@blog_details = BlogDetail.new
	end


	
	def create
		@blog_details = BlogDetail.new(blog_params)
		@blog_details[:topics] = [@blog_details[:blog_title]]
		byebug
		respond_to do |format|
	      if @blog_details.save
	        format.html { redirect_to 'admin_articles_path', notice: 'Blog details were added.' }
	        # format.json { render :show, status: :created, location: [:admin,@blog_details] }
	      else
	        format.html { render :new }
	        format.json { render json: @blog_details.errors, status: :unprocessable_entity }
	      end
    	end
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


