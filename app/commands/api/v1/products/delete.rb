module Api
  module V1
    module Products
      class Delete
        prepend SimpleCommand
        attr_reader :params, :current_user

        def initialize(params, current_user)
          @params = params
          @current_user = current_user
        end

        def call
          if current_user.admin?
            if product.destroy
              'Product deleted successfully.'
            else
              errors.add_multiple_errors(product.errors.full_messages)
              nil
            end
          else
            errors.add(:base, 'Unauthorized to delete this product.')
            nil
          end
        end
      end
    end
  end
end