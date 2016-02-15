class Admin::ArticlesController < Admin::BaseController
  
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  
  # GET /articles
  # GET /articles.json
  def index         
     @tag_list = Article.distinct(:tag)

    if params[:url]
      @articles = Article.all_in(tag: params[:url])
    else
      @articles = Article.all
    end    
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show    
    @comment = @article.comments.build
  end

  # GET /articles/new
  def new
    @article = Article.new    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @user = User.find(current_user.id)
    @article = @user.articles.new(article_params)
    @article[:tag] = params[:article][:tag].split(',').map{|item| item.strip}
    @article["Created"] = Time.now
    
    respond_to do |format|
      if @article.save
        format.html { redirect_to admin_articles_path, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: [:admin,@article] }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    @user = User.find(current_user.id)
    @article = Article.find(params[:id])
    @article[:tag] = params[:article][:tag].split(',').map{|item| item.strip}
    if @article.user_id == @user.id
      respond_to do |format|
        
          if @article.update(article_params)
            format.html { redirect_to [:admin, @article], notice: 'Article was successfully updated.' }
            format.json { render :show, status: :ok, location: @article }
          else
            format.html { render :edit }
            format.json { render json: @article.errors, status: :unprocessable_entity }
          end
        end
    else
      # flash.now.alert = "You are not allow to edit in this user session"
      redirect_to admin_articles_url, flash:{:alert=> "You are not allowed to edit in this user session"}
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    # @article = Article.find(params[:id])
    @article.destroy
    respond_to do |format|
      format.html { redirect_to admin_articles_url, notice: 'Article was successfully destroyed.' }
      # format.html { redirect_to admin_articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :published, :tag=>[])
    end
end
