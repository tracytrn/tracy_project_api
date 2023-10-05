class Api::V1::Customer::SessionsController < ApplicationController
  def create
    command = Api::V1::Customers::Authenticate.call(params[:email], params[:password])
    
    if command.success?
      render json: command.result
    else
      render json: { error: command.errors[:error] }, status: :unauthorized
    end
  end
end

