module Api
  module V1
    module Customers
      class Create
        prepend SimpleCommand
        attr_reader :params
        
        def initialize(params)
          @params = params
        end
        
        def call
          user = User.new(params.merge(role: 'customer'))

          if user.save
            UserPresenter.new(user).json_response
          else
            errors.add_multiple_errors(user.errors.full_messages)
            nil
          end
        end
      end  
    end
  end
end