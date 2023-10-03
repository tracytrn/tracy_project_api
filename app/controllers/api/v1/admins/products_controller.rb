class Api::V1::Admins::ProductsController < ApplicationController
  before_action :authenticate_user
  before_action :authenticate_admin!
  def index
    command = Api::V1::Products::List.call(params)

    if command.success?
      render json: command.result
    else
      render json: { errors: command.errors}
    end
  end

  def show
    command = Api::V1::Products::Show.call(params)

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
    command = Api::V1::Products::Create.call(product_params, current_user)

    if command.success?
      render json:command.result
    else
      render json: { errors:command.errors }
    end
  end

  def update
    command = Api::V1::Products::Update.call(product_params, current_user)
  
    if command.success?
      render json:command.result, status: :ok
    else
      render json: { errors:command.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    command = Api::V1::Products::Delete.call(params)
   
    if command.success?
      render json:command.result, status: :ok
    else
      render json: { errors:command.errors }, status: :unprocessable_entity
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :quantity, :description, :thumbnail)
  end
end