module Api
  module V1
    module Users
      class UpdateUserCommand
        prepend SimpleCommand

        def initialize(params)
          @params = params
        end
        
        def call
          user = User.find(@params[:id])
          if user.update(user_params)
            user
          else
            errors.add_mutiple_errors(user.errors.full_messages)
            nil
          end
        end

        private

        def user_params
          @params.require(:user).permit(:email, :password, :first_name, :last_name, :role)
        end
      end
    end
  end
end