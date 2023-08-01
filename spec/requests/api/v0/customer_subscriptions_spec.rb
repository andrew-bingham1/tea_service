require 'rails_helper'

RSpec.describe 'Customer Subscriptions API' do
  it 'can create a customer subscription' do
    customer_1 = Customer.create!(first_name: 'John', last_name: 'Doe', email: 'JD@email.com', address: '123 Anywhere St.')
    subscription_1 = Subscription.create!(title: 'Monthly Tea', price: 10.00, frequency: 1)

    customer_subscription_params = { customer_id: customer_1.id, subscription_id: subscription_1.id }

    post '/api/v0/customer_subscription', params: customer_subscription_params

    expect(response).to be_successful
    expect(response.status).to eq(201)

    reply = JSON.parse(response.body, symbolize_names: true)

    expect(reply).to be_a(Hash)
    expect(reply).to have_key(:message)
    expect(reply[:message]).to eq('New Subscription Created')
  end

  it 'can re-activate a cancelled customer subscription' do
    customer_1 = Customer.create!(first_name: 'John', last_name: 'Doe', email: 'JD@email.com', address: '123 Anywhere St.')
    subscription_1 = Subscription.create!(title: 'Monthly Tea', price: 10.00, frequency: 1)
    customer_subscription_1 = CustomerSubscription.create!(customer_id: customer_1.id, subscription_id: subscription_1.id, status: 1)

    customer_subscription_params = { customer_id: customer_1.id, subscription_id: subscription_1.id }

    post '/api/v0/customer_subscription', params: customer_subscription_params

    expect(response).to be_successful
    expect(response.status).to eq(200)

    reply = JSON.parse(response.body, symbolize_names: true)

    expect(reply).to be_a(Hash)
    expect(reply).to have_key(:message)
    expect(reply[:message]).to eq('Subscription Re-Activated')
  end

  it 'cannot re-activate an active customer subscription' do
    customer_1 = Customer.create!(first_name: 'John', last_name: 'Doe', email: 'JD@email.com', address: '123 Anywhere St.')
    subscription_1 = Subscription.create!(title: 'Monthly Tea', price: 10.00, frequency: 1)
    customer_subscription_1 = CustomerSubscription.create!(customer_id: customer_1.id, subscription_id: subscription_1.id, status: 0)

    customer_subscription_params = { customer_id: customer_1.id, subscription_id: subscription_1.id }

    post '/api/v0/customer_subscription', params: customer_subscription_params

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    reply = JSON.parse(response.body, symbolize_names: true)

    expect(reply).to be_a(Hash)
    expect(reply).to have_key(:error)
    expect(reply[:error]).to eq('Subscription Already Active')
  end

  it 'cannot create a customer subscription without a customer_id' do
    subscription_1 = Subscription.create!(title: 'Monthly Tea', price: 10.00, frequency: 1)
    customer_subscription_params = { subscription_id: subscription_1.id }

    post '/api/v0/customer_subscription', params: customer_subscription_params

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    reply = JSON.parse(response.body, symbolize_names: true)

    expect(reply).to be_a(Hash)
    expect(reply).to have_key(:error)
    expect(reply[:error]).to eq("Customer must exist and Customer can't be blank")
  end

  it 'cannot create a customer subscription without a subscription_id' do
    customer_1 = Customer.create!(first_name: 'John', last_name: 'Doe', email: 'JD@email.com', address: '123 Anywhere St.')
    customer_subscription_params = { customer_id: customer_1.id }

    post '/api/v0/customer_subscription', params: customer_subscription_params

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    reply = JSON.parse(response.body, symbolize_names: true)

    expect(reply).to be_a(Hash)
    expect(reply).to have_key(:error)
    expect(reply[:error]).to eq("Subscription must exist and Subscription can't be blank")
  end
end
