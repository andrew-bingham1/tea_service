class Api::V0::CustomersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def show
    customer = Customer.find(params[:id])
    render json: CustomerSerializer.new(customer), status: :ok
  end

  private 

  def record_not_found
    render json: { error: 'Customer Not Found' }, status: :not_found
  end
end
