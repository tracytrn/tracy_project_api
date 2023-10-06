class Api::V1::Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin?

  def index
    command = Api::V1::Categories::List.call(params)

    if command.success?
      render json: command.result
    else
      render json: { errors: command.errors}
    end
  end
  
  def products
    command = Api::V1::Categories::ListProducts.call(params)

    if command.success?
      render json: command.result, status: :ok
    else
      render json: { errors: command.errors }, status: :unprocessable_entity
    end
  end

  def show
    command = Api::V1::Categories::Show.call(params)

    if command.success?
      render json:command.result, status: :ok
    else
      render json: { errors:command.errors }, status: :unprocessable_entity
    end
  end

  def create
    command = Api::V1::Categories::Create.call(params)

    if command.success?
      render json:command.result, status: :created
    else
      render json: { errors:command.errors }, status: :unprocessable_entity
    end
  end

  def update
    command = Api::V1::Categories::Update.call(params)
  
    if command.success?
      render json:command.result, status: :ok
    else
      render json: { errors:command.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    command = Api::V1::Categories::Delete.call(params)
   
    if command.success?
      render json:command.result, status: :ok
    else
      render json: { errors:command.errors }, status: :unprocessable_entity
    end
  end

  private
  def category_params
    params.permit(:id, :name, :description, sub_categories_attributes: [:name, :description])
  end
end