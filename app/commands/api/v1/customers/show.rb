module Api
  module V1
    module Customers
      class Show
        prepend SimpleCommand
        attr_reader :params, :current_user

        def initialize(params, current_user)
          @params = params
          @current_user = current_user
        end
        
        def call
          user = User.customer.find_by(id: params[:id])
        
          if user
            if current_user.admin? || current_user.id == user.id
              UserPresenter.new(user).json_response
            else
              errors.add(:base, 'Unauthorized to show this user\'s information.')
              nil
            end
          else
            errors.add(:base, 'The user with this ID could not be found.')
            nil
          end
        end        
      end
    end
  end
end