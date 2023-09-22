module Api
  module V1
    module Users
      class ShowUserCommand
        prepend SimpleCommand
        

        def initialize(params)
          @params = params
        end
        
        def call
          user = User.find(@params[:id])
          if user 
            user
          else
            errors.add(:base, 'The user with this ID could not be found.')
            nil
          end
        end
      end
    end
  end
end