class JwtTokenable
  class << self
    EXPIRATION_TIME = 7.days.to_i

    def generate_jwt_token(payload)
      payload[:exp] = Time.now.to_i + EXPIRATION_TIME
      JWT.encode(payload, jwt_secret, 'HS256')
    end

    def decode_jwt_token(token)
      decoded_token = JWT.decode(token, jwt_secret, true, algorithm: 'HS256')
      decoded_token[0]
    rescue JWT::ExpiredSignature, JWT::DecodeError
      return nil
    end

    private

    def jwt_secret
      ENV["JWT_SECRET"]
    end
  end
end
