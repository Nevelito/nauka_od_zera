module Subscriptions
  class Subscribe
    def initialize(params, user)
      @params = params
      @user = user
    end

    def call
      new_subscription
      adding_points
      #sending_mails
    end
    def new_subscription
      @article = Article.find(@params[:article_id])

      if @article!=nil
        @user.subscribed_articles << @article
      else
        # error
      end
    end
    def adding_points
      @user.update!(points: @user.points + 10)
    end

    def sending_mails
      @article = Article.find(@params[:article_id])
      result = SubscriptionMailer.new_subscription_notification(@user, @article)

      if result[:success]
        # success
      else
        # error
      end
    end
  end
end

