class Api::V1::Admin::ProductsController < ApplicationController
  before_action :authenticate_admin?

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

  def create
    command = Api::V1::Products::Create.call(params)

    if command.success?
      render json:command.result
    else
      render json: { errors:command.errors }
    end
  end

  def update
    command = Api::V1::Products::Update.call(params)
  
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
    params.permit(:id, :name, :price, :quantity, :description, :thumbnail, product_categories_attributes: [:category_id])
  end
end