module Api
  module V1
    class ShowUserCommand
      prepend SimpleCommand

      def initialize(user_id)
        @user_id = user_id
      end
      
      def call
        user = User.find_by(id: @user_id)
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