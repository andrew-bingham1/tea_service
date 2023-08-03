require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :customer_subscriptions }
    it { should have_many(:subscriptions).through(:customer_subscriptions) }
  end

  describe 'instance methods' do
    it 'can give active subscriptions' do
      customer_1 = Customer.create!(first_name: 'Jim', last_name: 'Bob', email: 'jimmmybob@email.com', address: 'Springfield')
      subscription_1 = Subscription.create!(title: 'Monthly', price: 10, frequency: 1)

      expect(customer_1.active_subscriptions.count).to eq(0)

      customer_subscription_1 = CustomerSubscription.create!(customer_id: customer_1.id, subscription_id: subscription_1.id, status: 0)

      expect(customer_1.active_subscriptions.count).to eq(1)

      customer_subscription_1.update(status: 1)

      expect(customer_1.active_subscriptions.count).to eq(0)
    end

    it 'can give cancelled subscriptions' do
      customer_1 = Customer.create!(first_name: 'Jim', last_name: 'Bob', email: 'jimmmybob@email.com', address: 'Springfield')
      subscription_1 = Subscription.create!(title: 'Monthly', price: 10, frequency: 1)

      expect(customer_1.cancelled_subscriptions.count).to eq(0)

      customer_subscription_1 = CustomerSubscription.create!(customer_id: customer_1.id, subscription_id: subscription_1.id, status: 0)

      expect(customer_1.cancelled_subscriptions.count).to eq(0)

      customer_subscription_1.update(status: 1)

      expect(customer_1.cancelled_subscriptions.count).to eq(1)
    end
  end
end