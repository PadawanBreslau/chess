class ArticlesController < ApplicationController
  #load_and_authorize_resource

  def index
    @articles = Article.page(params[:page])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_path(@article)
    else
      redirect_to new_article_path
    end
  end

  def show
    @article = Article.find(params[:id])
    @title = @article.title
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update_attributes(article_params)
    if @article.save
      redirect_to articles_path(@article)
    else
      redirect_to :back
    end
  end

  def destroy
    Article.find(params[:id]).destroy
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :lead, :summary, :content, :site_user)
  end
end
