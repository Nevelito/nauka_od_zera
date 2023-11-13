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
      if @article
        @user.subscribed_articles << @article
      else
        raise ArgumentError, "Cannot create subscription without an article"
      end
    rescue StandardError => e
      puts "Error in new_subscription: #{e.message}"
    end

    def adding_points
      @user.update!(points: @user.points + 10)
    rescue StandardError => e
      puts "Error in adding_points: #{e.message}"
    end

    def sending_mails
      SubscriptionMailer.new_subscription_notification(@user, @article).deliver_now
    rescue StandardError => e
      puts "Error in sending_mails: #{e.message}"
    end
  end
end