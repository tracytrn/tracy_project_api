module Api
  module V1
    module Admins
      class Create
        prepend SimpleCommand
        attr_reader :params
        
        def initialize(params)
          @params = params
        end
        
        def call
          user = User.new(params.merge(role: 'admin'))

          if user.save
            UserPresenter.new(user).json_response
          else
            errors.add_mutiple_errors(user.errors.full_messages)
            nil
          end
        end
      end  
    end
  end
end