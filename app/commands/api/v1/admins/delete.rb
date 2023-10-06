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
              destroy_user(user)
            else
              errors.add(:base, 'Unauthorized to delete this admin\'s account.')
              nil
            end
          else
            errors.add(:base, 'No admin found with this ID.')
            nil
          end
        end

        private

        def destroy_user(user)
          Product.where(user_id: user.id).update_all(user_id: nil)
          Category.where(user_id: user.id).update_all(user_id: nil)

          if user.destroy
            { success: true, message: 'Admin\'s account successfully deleted' }
          else
            errors.add(:base, 'Admin\'s account deletion failed.')
            nil
          end
        end
      end
    end
  end
end
