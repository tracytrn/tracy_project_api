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

    set_current_user(result)
  end

  def token_missing?
    token.blank?
  end

  def render_missing_token_error
    render json: { error: 'Token missing' }, status: :unauthorized
  end

  def render_invalid_token_error
    render json: { error: 'Invalid Token' }, status: :unauthorized
  end

  def token
    @token ||= request.headers['Authorization']
  end

  def set_current_user(result)
    @current_user = result
  end

  def authenticate_admin
    render_invalid_token_error unless current_user&.admin?
  end  
end

