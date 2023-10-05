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
          return nil unless current_user.admin? #Kane: Remove this

          product = create_product
          return ProductPresenter.new(product).json_response if product.persisted?

          errors.add_multiple_errors(product.errors.full_messages)
          nil
        end

        private

        def create_product
          product = Product.new(product_params)
          product.user_id = current_user.id

          if product.save
            assign_categories_to_product(product)
            product
          else
            product
          end
        end

        def assign_categories_to_product(product)
          if params[:product_categories_attributes].present?
            category_ids = params[:product_categories_attributes].map { |pc| pc[:category_id] }
            product.category_ids = category_ids
          end
        end

        def product_params
          params.permit(:name, :price, :quantity, :description, :thumbnail)
        end
      end
    end
  end
end
