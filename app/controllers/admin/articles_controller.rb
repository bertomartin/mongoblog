class Admin::ArticlesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def tags(tag_list)
      @article = Article.all
      
      list_of_non_existing_tags = Array.new

      tag_list.each do |t|
          tag_exist = false
          @article.each do |article|
            article[:tag].each do |a|
              if t.downcase == a
                 tag_exist = true
              end
            end
          end
          if !tag_exist
            list_of_non_existing_tags.push(t)
          end          
      end
      list_of_non_existing_tags
  end

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all

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
    a = Array.new
    @article = Article.new(article_params)
    input_tag = params[:article][:tag].split(',')
    @article[:tag] = params[:article][:tag].split(',')
    
    tag_list = tags(input_tag)
    if !tag_list.empty?
      tag_list.each do |tag|
       a.push(tag)
      end
      @article[:tag] = a
    end
    

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

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
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
