class SubscriptionMailer < ApplicationMailer
  def new_subscription_notification(subscriber, article)
    raise ArgumentError, "Subscriber cannot be nil" if subscriber.nil?
    raise ArgumentError, "Article cannot be nil" if article.nil?

    @subscriber = subscriber
    @article = article


    mail(to: subscriber.email, subject: "You subscribe new article which title is #{article.title}")
  end
  def delete_subscription_notification(subscriber, article)
    raise ArgumentError, "Subscriber cannot be nil" if subscriber.nil?
    raise ArgumentError, "Article cannot be nil" if article.nil?

    @subscriber = subscriber
    @article = article

    mail(to: subscriber.email, subject: "You unsubscribe article which title is #{article.title}")

  end
end
