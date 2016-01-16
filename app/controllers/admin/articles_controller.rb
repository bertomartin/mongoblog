class Admin::ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def new
    @article = Article.new
  end

  def edit
  end

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def update
    #todo: handle article update
  end

  def destroy
    #todo: handle destroy
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

end
