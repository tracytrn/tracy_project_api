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
          user = User.find_by(id: params[:id])

          if user.update(user_params)
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