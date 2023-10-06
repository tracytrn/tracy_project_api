module Api
  module V1
    module Customers
      class Delete
        prepend SimpleCommand
        attr_reader :params, :current_user

        def initialize(params, current_user)
          @params = params
          @current_user = current_user
        end
      
        def call
          user = User.customer.find_by(id: params[:id])
          if user
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
          else
            errors.add(:base, 'User not found.')
            nil
          end
        end
      end
    end
  end
end
