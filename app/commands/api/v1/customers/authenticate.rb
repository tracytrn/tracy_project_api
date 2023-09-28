module Api
  module V1
    module Customers
      class Authenticate
        prepend SimpleCommand
        attr_reader :email, :password

        def initialize(email, password)
          @email = email
          @password = password
        end

        def call
          user = User.find_by(email: email)

          unless user&.customer? && user.authenticate(password)
            errors.add(:error, "Please check your Email or Password.")
            return nil
          end

          exp = 1.minutes.from_now
          payload = { user_id: user.id, exp: exp.to_i }
          token = JwtTokenable.generate_jwt_token(payload)

          return { user: UserPresenter.new(user).json_response, auth_token: token }
        end
      end
    end
  end
end
