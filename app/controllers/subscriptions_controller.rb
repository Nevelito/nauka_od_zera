class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    Subscriptions::Subscribe.new(params,current_user,article).call
    redirect_to article, notice: 'Subscribed to the article.'
  end

  def destroy
    Subscriptions::Unsubscribe.new(params,current_user,subscription,article).call
    redirect_to article, notice: 'Unsubscribed from the article.'
  end

  private

  def subscription
    @subscription ||= current_user.subscriptions.find_by(article_id: params[:article_id])
  end

  def article
    @article ||= Article.find_by(id: params[:article_id])
  end


end
