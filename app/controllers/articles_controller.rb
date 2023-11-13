class ArticlesController < ApplicationController

  before_action :authenticate_user!
  def new
    @article = Article.new
  end

  def index
    @articles = Article.order(id: :asc)
  end

  def create
    # @article = current_user.articles.new(article_params)
    result = Articles::Create.new(article_params).call

    if result[:success] == true
      redirect_to articles_path
    else
      flash[:alert] = result[:errors]
      render :new
    end

  end

  def show
    @article = Article.find_by(id: params[:id])

    if @article
      render 'show'
    else
      flash[:alert] = "Error showing the article."
      redirect_to articles_path
    end
  end

  def destroy
    @article = Article.find_by(id: params[:id])

    if @article
      if @article.destroy
        redirect_to articles_path, notice: "Article was successfully deleted."
      else
        flash[:alert] = "Error deleting the article."
        redirect_to articles_path
      end
    else
      flash[:alert] = "Article not found."
      redirect_to articles_path
    end
  end


  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end
  def edit
    @article = Article.find_by(id: params[:id])

    if @article
      render 'edit'
    else
      flash[:alert] = "Article not found."
      redirect_to articles_path
    end
  end

  def my_articles
    @my_articles = current_user.articles

    if @my_articles.empty?
      flash[:notice] = "You have no articles."
      redirect_to articles_path
    end
  end

  def subscripted_article
    my_subscriptions = current_user.subscriptions
    @articles = Article.where(id: my_subscriptions.pluck(:article_id))

    if @articles.empty?
      flash[:notice] = "You are not subscribed to any articles."
      redirect_to articles_path
    end
  end


  private

  def article_params
    params.require(:article).permit(:title, :entry, :contents, :user_id) # Replace with the actual permitted attributes
  end
end