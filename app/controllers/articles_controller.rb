require 'mailchimp'

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  

  def feed
    @articles = Article.all
    respond_to do |format|
      format.rss { render :layout => false }
    end
  end

  # # GET /articles
  # # GET /articles.json
  def index

    @current_page = 1
    @top_articles = Article.order_by(view_count: :desc)     
    @tag_list = Article.distinct(:tag)

    if params[:url] #and params[:url].match('[A-Za-z]')
      params_url = params[:url]
      articles =  Article.all_in(tag: params[:url])
      page_info = get_page_params(articles)
      @number_of_pages = page_info['number_of_pages']

      #These are appliction helper functions
      @scroll = page_scroll(params, @number_of_pages)
      @scroll_tag = true
      @articles = get_articles(params, page_info['offset'], articles)
    else
      articles =  Article.all
      page_info = get_page_params(articles)
      @number_of_pages = page_info['number_of_pages']

      @scroll = page_scroll(params, @number_of_pages)  #from ApplicationHelper
      @articles = get_articles(params, page_info['offset'], articles) #from ApplicationHelper
    end

    @user_subscription = UserSubscription.new
    #TODO Check for valid email. Add email confirmation to ensure valid emails are added.    
    respond_to do |format|
      if params[:email].blank?
        format.html # index.html.erb
        format.json { render json: @articles }
      else
        user_info = UserSubscription.find_by(:email=>params[:email]) 
        email = params[:email]
        
        if user_info            
            format.html{redirect_to articles_path, notice: "#{email} is already in database" } # index.html.erb
            format.json { render json: @articles }          
        else
          #Send email when a user subscribe
          @user_subscription= UserSubscription.create(:email=> params[:email])          
          mailchimp_api_key = Rails.application.secrets.mailchimp_api_key
          list_id = Rails.application.secrets.list_id

          mailchimp = Mailchimp::API.new(mailchimp_api_key)
          mailchimp.lists.subscribe(list_id, {"email" => email})

          format.html{redirect_to articles_path, notice: "#{email} has been added." } # index.html.erb
          format.json { render json: @articles }
        end
      end          
    end
  end

  # # GET /articles/1
  # # GET /articles/1.json
  def show
    @comment = @article.comments.build
    articles = @@mongodb[:articles]

    articles.find("_id"=>@article.id).update_one("$inc" => { :view_count => 1 })

    @article_present = articles.find({tag: { "$in": @article.tag} }).count    
    @related_articles = articles.find({tag: { "$in": @article.tag} }).find_all

    if @article_present > 1
      @related_articles
    else
      @related_articles = Article.order_by(view_count: :desc)
    end
    # db.articles.find({ tag: { $all: ["Software"] } } )
  end

  # # GET /articles/new
  def new
    @article = Article.new
  end

  # # GET /articles/1/edit
  def edit
  end

  # # POST /articles
  # # POST /articles.json
  def create    
    @article = Article.new(article_params)    
    @article[:tag] = params[:article][:tag].split(',')    

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # # PATCH/PUT /articles/1
  # # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # # DELETE /articles/1
  # # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  #   # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :published, :tag=>[], :authors=>[], :view_count=>0)
    end

    # def get_articles(params, offset, articles)
    #   if params[:pg].to_i > 0 && params[:pg].to_i > 1
    #      @current_page = (params[:pg].to_i * offset).to_i
    #      @articles =  articles.skip(@current_page - offset).limit(offset) 
    #   else
    #       @articles = articles.limit(offset)      
    #   end    
    # end
end