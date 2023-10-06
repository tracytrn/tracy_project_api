module Api
  module V1
    module Products
      class Create
        prepend SimpleCommand
        attr_reader :params

        def initialize(params)
          @params = params
        end

        def call
          product = create_product
          return ProductPresenter.new(product).json_response if product.persisted?

          errors.add_multiple_errors(product.errors.full_messages)
          nil
        end

        private

        def create_product
          product = Product.new(product_params)

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
          params.permit(:name, :price, :quantity, :description, :thumbnail, product_categories_attributes: [:category_id])
        end
      end
    end
  end
end
