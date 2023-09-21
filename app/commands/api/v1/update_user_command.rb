module Api
  module V1
    class UpdateUserCommand
      prepend SimpleCommand

      def initialize(user_id, params)
        @user_id = user_id
        @params = params
      end
      
      def call
        user = User.find_by(id: @user_id)

        if user.update(@params)
          user
        else
          errors.add_mutiple_errors(user.errors.full_messages)
          nil
        end
      end
    end
  end
end