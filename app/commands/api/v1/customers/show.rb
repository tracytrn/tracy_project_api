module Api
  module V1
    module Customers
      class Show
        prepend SimpleCommand
        attr_reader :params

        def initialize(params)
          @params = params
        end
        
        def call
          user = User.find(params[:id])
          if user 
            user_decorator = user.decorator
            user_decorator.json_response
          else
            errors.add(:base, 'The user with this ID could not be found.')
            nil
          end
        end
      end
    end
  end
end