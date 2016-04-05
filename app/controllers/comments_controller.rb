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
    @user = User.find(current_user.id)
    settings = @user.setting
    
    if settings[0]['how_to_email'] == 'email_weekly'
      #do something
    else
      respond_to do |format|
        if @comment.save
          CommentMailer.notify_on_comment(@user, @article).deliver
          
          format.html {redirect_to @article, notice: 'Comment was successfully created.'}
        else
          format.html { redirect_to @article }
        end
      end
    end
  end

  def update
  end

  def destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:name, :body)
    end

    def load_article
      @article = Article.find(params[:article_id])
    end
end
