module Api
  module V1
    module Products
      class Update
        prepend SimpleCommand
        attr_reader :params, :current_user

        def initialize(params)
          @params = params
          @current_user = current_user
        end
      
        def call
          product = Product.find(params[:id])

          if current_user.admin?
            if product.update(product_params)
              productPresenter.new(product).json_response
            else
              errors.add(:base, 'Product\'s information update failed.')
              nil
            end
          else
            errors.add(:base, 'Unauthorized to update this product\'s information.')
            nil
          end
        end
      
        private
      
        def product_params
          permitted_params = params.permit(:name,:price, :quantity, :description, :thumbnail)
          
          # Check if the current user is an admin
          if current_user&.admin?
            permitted_params[:user_id] = current_user.id
          end

          permitted_params
        end
      end
    end
  end
end