class Customer < ApplicationRecord 
  has_many :customer_subscriptions
  has_many :subscriptions, through: :customer_subscriptions

  def active_subscriptions
    subscriptions.joins(:customer_subscriptions).where('customer_subscriptions.status = ?', 0)
  end

  def cancelled_subscriptions
    subscriptions.joins(:customer_subscriptions).where('customer_subscriptions.status = ?', 1)
  end
end