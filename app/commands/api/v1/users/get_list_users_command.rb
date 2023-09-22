module Api
  module V1
    module Users
      class GetListUsersCommand
        prepend SimpleCommand

        def initialize(params)
          @params = params
        end
        
        def call
          users = User.filter_user_by(@params)
          if users
            users
          else
            errors.add_mutiple_errors(user.errors.full_messages)
            nil
          end
        end
      end
    end
  end
end