class Api::V1::CustomersController < ApplicationController
  before_action :authenticate_admin!, only: [:index]
  
  def index
    command = Api::V1::Customers::List.call(customer_params)

    if command.success?
      render json: command.result
    else
      render json: { errors: command.errors }
    end
  end
  
  def show
    command = Api::V1::Customers::Show.call(params, current_user)

    if command.success?
      render json:command.result, status: :ok
    else
      render json: { errors:command.errors }, status: :unprocessable_entity
    end
  end

  def new
  end

  def edit
  end

  def create
   command = Api::V1::Customers::Create.call(user_params)

    if command.success?
      render json:command.result
    else
      render json: { errors:command.errors }
    end
  end

  def update
   command = Api::V1::Customers::Update.call(params, current_user)
    
    if command.success?
      render json:command.result, status: :ok
    else
      render json: { errors:command.errors }, status: :unprocessable_entity
    end
  end

  def destroy
   command = Api::V1::Customers::Delete.call(params, current_user)
   
    if command.success?
      render json:command.result, status: :ok
    else
      render json: { errors:command.errors }, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.permit(:email, :password, :first_name, :last_name, :role)
  end

  def customer_params
    params.permit(:keyword, :page, :per_page)
  end
end