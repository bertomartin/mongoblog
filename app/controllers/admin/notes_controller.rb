class Admin::NotesController < Admin::BaseController
  
  before_action :load_article
  # before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @notes = @article.notes
  end

  def new
    @notes = @article.notes.build
  end

  def edit
  end

  def show
    @article = Article.find(params[:article_id])    
    @notes = @article.notes.find(params[:id])
  end

  def create
    @note = @article.notes.build(notes_params)
    respond_to do |format|
      if @note.save
        format.html {redirect_to admin_article_path(@article), notice: 'Note was successfully added.'}
      else
        format.html { redirect_to @article }
      end
    end
  end

  def update
  end

  def destroy

    @article = Article.find(params[:article_id])
    @notes = @article.notes.find(params[:id])
    if @notes
      @notes.destroy
    end
    redirect_to admin_article_path(@article)
  end

  private
    def notes_params
      params.require(:note).permit(:notes_info)
    end

    def load_article
      @article = Article.find(params[:article_id])
    end
end
