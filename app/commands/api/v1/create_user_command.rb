module Api
  module V1
    class CreateUserCommand
      prepend SimpleCommand
      
      def initialize(params)
        @params = params
      end
      
      def call
        user = User.new(@params)

        if user.save
          user
        else
          errors.add_mutiple_errors(user.errors.full_messages)
          nil
        end
      end
    end
  end
end