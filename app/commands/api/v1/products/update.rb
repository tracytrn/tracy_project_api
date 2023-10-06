module Api
  module V1
    module Products
      class Update
        prepend SimpleCommand
        attr_reader :params

        def initialize(params)
          @params = params
        end

        def call

          product = update_product
          if product.errors.any?
            errors.add_multiple_errors(product.errors.full_messages)
            nil
          else
            ProductPresenter.new(product).json_response
          end
        end

        private

        def update_product
          product = Product.find_by(id: params[:id])

          if product
            product.update(product_params)
            assign_categories_to_product(product)
          else
            errors.add(:base, 'No product found with this ID.')
          end

          product
        end

        def assign_categories_to_product(product)
          if params[:product_categories_attributes].present?
            category_ids = params[:product_categories_attributes].map { |pc| pc[:category_id] }
            product.category_ids = category_ids
          else
            product.category_ids = [] # Remove all categories if none are provided
          end
        end

        def product_params
          params.permit(:name, :price, :quantity, :description, :thumbnail, product_categories_attributes: [:category_id])
        end
      end
    end
  end
end
