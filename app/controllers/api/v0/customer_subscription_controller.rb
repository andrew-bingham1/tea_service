class Api::V0::CustomerSubscriptionController < ApplicationController

  def create
    existing_customer_subscription = CustomerSubscription.find_by(customer_subscription_params)
  
    if existing_customer_subscription
      if existing_customer_subscription.status == 'cancelled'
        existing_customer_subscription.update(status: 'active')
        render json: { message: 'Subscription Re-Activated'}, status: :ok
      elsif existing_customer_subscription.status == 'active'
        render json: { error: 'Subscription Already Active' }, status: :bad_request
      end
    else
      new_customer_subscription = CustomerSubscription.new(customer_subscription_params)
      if new_customer_subscription.save
        render json: { message: 'New Subscription Created'}, status: :created
      else
        render json: { error: new_customer_subscription.errors.full_messages.to_sentence }, status: :bad_request
      end
    end
  end
  
  private

  def customer_subscription_params
    params.permit(:customer_id, :subscription_id)
  end
end