module Api
  module V1
    module Users
      class AuthenticateCommand
        include JwtTokenable
        prepend SimpleCommand
        attr_reader :email, :password
      
        def initialize(email, password)
          @email = email
          @password = password
        end
      
        def call
          user = User.find_by(email: email)
          
          unless user && user.authenticate(password)
            errors.add(:error, "Please check your Email or Password.")
            return nil
          end
      
          payload = { user_id: user.id }
          token = generate_jwt_token(payload)
      
          return { user: user, auth_token: token }
        end
      end
    end
  end
end
