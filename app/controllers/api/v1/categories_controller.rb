class Api::V1::CategoriesController < ApplicationController
  
  def index
    command = Api::V1::Categories::List.call(params)

    if command.success?
      render json: command.result
    else
      render json: { errors: command.errors}
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
end