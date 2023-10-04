module Api
  module V1
    module Customers
      class Update
        prepend SimpleCommand
        attr_reader :params, :current_user

        def initialize(params, current_user)
          @params = params
          @current_user = current_user
        end
      
        def call
          user = User.find_by(id: params[:id])

          if user
            if current_user.admin? || current_user.id == user.id
              if user.update(user_params)
                UserPresenter.new(user).json_response
              else
                errors.add_multiple_errors(user.errors.full_messages)
                nil
              end
            else
              errors.add(:base, 'Unauthorized to update this user account.')
              nil
            end
          else
            errors.add(:base, 'No user found with this ID.')
            nil
          end
        end
      
        private
      
        def user_params
          params.permit(:email, :password, :first_name, :last_name, :role)
        end
      end
    end
  end
end

