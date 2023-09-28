class ApplicationController < ActionController::API
  private
  def authenticate_user
    if token_missing?
      render_missing_token_error
      return
    end

    result = JwtTokenable.decode_jwt_token(token)
    if result.nil?
      render_invalid_token_error
      return
    end

    current_user(result)
  end

  def token_missing?
    token.blank?
  end

  def render_missing_token_error
    render json: { error: 'Token missing' }, status: :unauthorized
  end

  def render_invalid_token_error
    render json: { error: 'The token is invalid or expired.'}, status: :unauthorized
  end

  def token
    @token ||= request.headers['Authorization']
  end

  def current_user(result)
    user_id = result["user_id"]
    @current_user ||= User.find_by(id: user_id)
  end

  def authenticate_admin!
    render_invalid_token_error unless @current_user&.admin?
  end
end


