module Api
  module V1
    module Users
      class DeleteUserCommand
        prepend SimpleCommand
        attr_reader :user_id

        def initialize(user_id)
          @user_id = user_id
        end
        
        def call
          user = User.find_by(id: user_id)
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