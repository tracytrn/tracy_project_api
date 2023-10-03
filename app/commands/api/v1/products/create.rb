module Api
  module V1
    module Products
      class Create
        prepend SimpleCommand
        attr_reader :params, :current_user

        def initialize(params, current_user)
          @params = params
          @current_user = current_user
        end

        def call
          product = Product.new(product_params)

          if product.save
            ProductPresenter.new(product).json_response
          else
            errors.add_multiple_errors(product.errors.full_messages)
            nil
          end
        end

        private

        def product_params
          permitted_params = params.permit(:name, :price, :quantity, :description, :thumbnail)
          
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