class JwtTokenable

  class << self
    def generate_jwt_token(payload)
      JWT.encode(payload, ENV["JWT_SECRET"], 'HS256')
    end

    def decode_jwt_token(token)
      decoded_token = JWT.decode(token, ENV["JWT_SECRET"], true, algorithm: 'HS256')
    rescue JWT::ExpiredSignature, JWT::DecodeError
      return nil
    end
  end
end