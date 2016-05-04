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
    @top_articles = Article.order_by(view_count: :desc)    
    
    @tag_list = Article.distinct(:tag)

    if params[:url]
      @articles = Article.all_in(tag: params[:url])
    else
      @articles = Article.all
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
    @related_articles = articles.find({tag: { "$in": @article.tag} }).find_all
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
end
