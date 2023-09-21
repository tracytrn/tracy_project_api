class Api::V1::UsersController < ApplicationController
  def index
    users = Api::V1::GetListUsersCommand.call(params)
    if users.success?
      render json: users.result
    else
      render json: { errors: users.errors}
    end
  end
  
  def show
    user = Api::V1::ShowUserCommand.call(params[:id])
    if user.success?
      render json: user.result
    else
      render json: { errors: user.errors}
    end
  end

  def new
  end

  def edit
  end

  def create
    user = Api::V1::CreateUserCommand.call(user_params)
    if user.success?
      render json: user.result
    else
      render json: { errors: user.errors }
    end
  end

  def update
    user = Api::V1::UpdateUserCommand.call(params[:id], user_params)
    if user.success?
      render json: user.result
    else
      render json: { errors: user.errors }
    end
  end

  def destroy
    user = Api::V1::DeleteUserCommand.call(params[:id])
    if user.success?
      render json: user.result
    else
      render json: { errors: user.errors }
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password_digest, :first_name, :last_name, :role)
  end
end