class Api::V1::CustomersController < ApplicationController
  before_action :authenticate_user, only: [:update, :destroy] 
  def index
    command = Api::V1::Customers::List.call(customer_params)
    if command.success?
      render json: command.result
    else
      render json: { errors: command.errors }
    end
  end
  
  def show
    command = Api::V1::Customers::Show.call(params)
    if command.success?
      render json:command.result, status: :ok
    else
      render json: { errors:command.errors }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :internal_server_error
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
   command = Api::V1::Customers::Update.call(params)
    
    if command.success?
      render json:command.result, status: :ok
    else
      render json: { errors:command.errors }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :internal_server_error
  end

  def destroy
   command = Api::V1::Customers::Delete.call(params)
   
    if command.success?
      render json:command.result, status: :ok
    else
      render json: { errors:command.errors }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
      render json: { error: 'User not found' }, status: :internal_server_error
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :role)
  end

  def customer_params
    params.permit(:search_key, :page, :per_page)
  end
end