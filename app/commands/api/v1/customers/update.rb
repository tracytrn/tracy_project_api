module Api
  module V1
    module Customers
      class Update
        prepend SimpleCommand
        attr_reader :params

        def initialize(params)
          @params = params
        end
      
        def call
          user = User.find(params[:id])
          if user.update(user_params.merge(role: 'customer'))
            UserPresenter.new(user).json_response
          else
            errors.add(:base, 'The user with this ID could not be found.')
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