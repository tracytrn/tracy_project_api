module Api
  module V1
    module Users
      class DeleteUserCommand
        prepend SimpleCommand

        def initialize(params)
          @params = params
        end
        
        def call
          user = User.find(@params[:id])
          if user
            user.destroy
            'Account deleted successfully.'
          else
            errors.add(:base, 'No user found with this ID.')
            nil
          end
        end
      end
    end
  end
end