module Api
  module V1
    module Admins
      class Delete
        prepend SimpleCommand
        attr_reader :params, :current_user

        def initialize(params, current_user)
          @params = params
          @current_user = current_user
        end
        
        def call
          user = User.find_by(id: params[:id])
          
          if user
            if current_user.admin? && current_user.id == user.id
              user.destroy
              { message: 'Account deleted successfully' }
            else
              errors.add(:base, 'Unauthorized to delete this admin account.')
              nil
            end
          else
            errors.add(:base, 'No admin found with this ID.')
            nil
          end
        end
      end
    end
  end
end
