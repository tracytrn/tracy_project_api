module Api
  module V1
    module Admins
      class Update
        prepend SimpleCommand
        attr_reader :params

        def initialize(params)
          @params = params
        end
      
        def call
          user = User.find(params[:id])
          if user.update(user_params.merge(role: 'admin'))
            user
          else
            errors.add_multiple_errors(user.errors.full_messages)
            nil
          end
        rescue ActiveRecord::RecordNotFound
          raise ActiveRecord::RecordNotFound, 'User not found'
        end
      
        private
      
        def user_params
          params.require(:user).permit(:email, :password, :first_name, :last_name, :role)
        end
      end
    end
  end
end