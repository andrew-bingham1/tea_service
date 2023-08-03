require 'rails_helper'

RSpec.describe 'Customer API' do
  describe 'happy path' do
    it 'can return customer data' do
      customer_1 = Customer.create!(first_name: 'Jim', last_name: 'Bob', email: 'jimmmybob@email.com', address: 'Springfield')
      subscription_1 = Subscription.create!(title: 'Monthly', price: 10, frequency: 1)
      subscription_2 = Subscription.create!(title: 'Weekly', price: 40, frequency: 4)
      customer_subscription_1 = CustomerSubscription.create!(customer_id: customer_1.id, subscription_id: subscription_1.id, status: 0)
      customer_subscription_2 = CustomerSubscription.create!(customer_id: customer_1.id, subscription_id: subscription_2.id, status: 1)

      get '/api/v0/customers', params: { id: customer_1.id}
      expect(response).to be_successful
      expect(response.status).to eq(200)

      reply = JSON.parse(response.body, symbolize_names: true)

      expect(reply).to be_a(Hash)
      expect(reply).to have_key(:data)

      expect(reply[:data]).to be_a(Hash)
      expect(reply[:data]).to have_key(:id)
      expect(reply[:data][:id]).to eq(customer_1.id.to_s)

      expect(reply[:data]).to have_key(:type)
      expect(reply[:data][:type]).to eq('customer')

      expect(reply[:data]).to have_key(:attributes)
      expect(reply[:data][:attributes]).to be_a(Hash)

      expect(reply[:data][:attributes][:first_name]).to eq(customer_1.first_name)
      expect(reply[:data][:attributes][:last_name]).to eq(customer_1.last_name)
      expect(reply[:data][:attributes][:email]).to eq(customer_1.email)
      expect(reply[:data][:attributes][:address]).to eq(customer_1.address)

      expect(reply[:data][:attributes]).to have_key(:active_subscriptions)
      expect(reply[:data][:attributes][:active_subscriptions]).to be_an(Array)
      expect(reply[:data][:attributes][:active_subscriptions].count).to eq(1)

      expect(reply[:data][:attributes]).to have_key(:cancelled_subscriptions)
      expect(reply[:data][:attributes][:cancelled_subscriptions]).to be_a(Array)
      expect(reply[:data][:attributes][:cancelled_subscriptions].count).to eq(1)
    end
  end

  describe 'sad path' do
    it 'cannot return customer data if customer does not exist' do
      get '/api/v0/customers', params: { id: 1 }

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      reply = JSON.parse(response.body, symbolize_names: true)

      expect(reply).to be_a(Hash)
      expect(reply).to have_key(:error)
      expect(reply[:error]).to eq('Customer Not Found')
    end
  end
end