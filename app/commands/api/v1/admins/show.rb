module Api
  module V1
    module Admins
      class Show
        prepend SimpleCommand
        attr_reader :params

        def initialize(params)
          @params = params
        end
        
        def call
          user = User.find_by(id: params[:id])
          if user 
            UserPresenter.new(user).json_response
          else
            errors.add(:base, 'The user with this ID could not be found.')
            nil
          end
        end
      end
    end
  end
end