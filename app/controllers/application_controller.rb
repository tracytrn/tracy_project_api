class ApplicationController < ActionController::API
  
  private
  
  def authenticate_user
    token = request.headers['Authorization']
    if token.blank?
      render json: { error: 'Token missing' }, status: :unauthorized
      return
    end

    result = JwtTokenable.decode_jwt_token(token)
    unless result
      render json: { error: 'Invalid Token' }, status: :unauthorized
      return
    end

    @current_user = result
  end
end
