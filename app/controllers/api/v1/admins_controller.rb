class Api::V1::AdminsController < ApplicationController
  before_action :authenticate_user, only: [:update, :destroy] 
  def index
    command = Api::V1::Admins::List.call(admin_params)
    if command.success?
      render json: command.result
    else
      render json: { errors: command.errors}
    end
  end
  
  def show
    command = Api::V1::Admins::Show.call(params)
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
   command = Api::V1::Admins::Create.call(user_params)
    if command.success?
      render json:command.result
    else
      render json: { errors:command.errors }
    end
  end

  def update
   command = Api::V1::Admins::Update.call(params)
    
    if command.success?
      render json:command.result, status: :ok
    else
      render json: { errors:command.errors }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :internal_server_error
  end

  def destroy
   command = Api::V1::Admins::Delete.call(params)
   
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

  def admin_params
    params.permit(:search_key, :page, :per_page)
  end
end