class ApplicationController < ActionController::API

  private
  def current_user
    @current_user ||= User.find_by(id: token_payload&.dig(:id))
  end

  def token
    @token ||= request.headers['Authorization']
  end

  def token_payload
    JwtTokenable.decode_jwt_token(token)
  end

  def authenticate_user
    unless current_user
      render_unauthorized('Invalid Token')
    end
  end

  def authenticate_admin?
    unless current_user&.admin?
      render_unauthorized('Admin access required')
    end
  end

  def render_unauthorized(message)
    render json: { error: message }, status: :unauthorized
  end

end