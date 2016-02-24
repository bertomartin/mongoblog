class Admin::CommentsController < Admin::BaseController
  
  before_action :load_article
  # before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = @article.comments
  end

  def new
    @comment = @article.comments.build
  end

  def edit
  end

  def show
    @article = Article.find(params[:article_id])    
    @comments = @article.comments.find(params[:id])
  end

  def create
    @comment = @article.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.html {redirect_to @article, notice: 'Comment was successfully created.'}
      else
        format.html { redirect_to @article }
      end
    end
  end

  def update
  end

  def destroy

    @article = Article.find(params[:article_id])
    @comments = @article.comments.find(params[:id])
    if @comments
      @comments.destroy
    end
    redirect_to admin_article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:name, :body)
    end

    def load_article
      @article = Article.find(params[:article_id])
    end
end
