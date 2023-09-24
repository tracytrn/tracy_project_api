class ApplicationController < ActionController::API
  include JwtTokenable

  private

  def authenticate_user
    token = request.headers['Authorization']
    if token.blank?
      render json: { error: 'Token missing' }, status: :unauthorized
      return
    end

    result = decode_jwt_token(token)
    unless result
      render json: { error: 'Invalid Token' }, status: :unauthorized
    end
  end
end
