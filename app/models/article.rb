class Article < ApplicationRecord
  belongs_to :user
  # has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user
end
