class Api::V1::AdminsController < ApplicationController
  before_action :authenticate_admin?
  
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
   command = Api::V1::Admins::Update.call(params, current_user)
    
    if command.success?
      render json:command.result, status: :ok
    else
      render json: { errors:command.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    command = Api::V1::Admins::Delete.call(params, current_user)
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

  def admin_params
    params.permit(:keyword, :page, :per_page)
  end
end