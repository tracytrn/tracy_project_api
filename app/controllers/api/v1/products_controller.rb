class Api::V1::ProductsController < ApplicationController
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
end