class CommentsController < ApplicationController
  before_action :load_article
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = @article.comments
  end

  def new
    @comment = @article.comments.build
  end

  def edit
  end

  def create
    @comment = @article.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.html {redirect_to @article, notice: 'Comment was successfully created.'}
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
  end

  def destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end

    def load_article
      @article = Article.find(params[:article_id])
    end
end
