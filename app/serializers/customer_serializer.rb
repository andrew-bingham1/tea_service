class CustomerSerializer
  include JSONAPI::Serializer
  attributes :id,
             :first_name, 
             :last_name,
             :email,
             :address

  attribute :active_subscriptions do |customer|
    customer.active_subscriptions.map do |subscription|
      { 
        id: subscription.id,
        title: subscription.title,
        price: subscription.price,
        frequency: subscription.frequency
      }
    end
  end

  attribute :cancelled_subscriptions do |customer|
    customer.cancelled_subscriptions.map do |subscription|
      {
        id: subscription.id,
        title: subscription.title,
        price: subscription.price,
        frequency: subscription.frequency
      }
    end
  end
end