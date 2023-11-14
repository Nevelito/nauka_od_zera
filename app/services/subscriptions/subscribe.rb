module Subscriptions
  class Subscribe
    def initialize(params, user, article)
      @params = params
      @user = user
      @article = article
    end

    def call
      new_subscription
      adding_points
      sending_mails
    end

    def new_subscription
      @user.subscribed_articles << @article

      if !@user.subscribed_articles.include?(@article)
        flash[:alert] = "Error creating the subscription."
        redirect_to @article
      end
    end

    def adding_points
      @user.update!(points: @user.points + 10)
    end

    def sending_mails
      SubscriptionMailer.new_subscription_notification(@user, @article).deliver_now
    end
  end
end