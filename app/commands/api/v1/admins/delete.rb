module Api
  module V1
    module Admins
      class Delete
        prepend SimpleCommand
        attr_reader :params, :current_user

        def initialize(params)
          @params = params
          @current_user = current_user
        end
        
        def call
          user = User.find(params[:id])
          
          if current_user.admin? || current_user.id == user.id
            if user.destroy
              { success: true, message: 'User successfully deleted' }
            else
              errors.add(:base, 'User deletion failed.')
              nil
            end
          else
            errors.add(:base, 'Unauthorized to delete this user.')
            nil
          end
        end
      end
    end
  end
end