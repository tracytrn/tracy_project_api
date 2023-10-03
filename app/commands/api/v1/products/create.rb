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
          product = Product.new(product_params)

          if product.save
            ProductPresenter.new(product).json_response
          else
            errors.add_multiple_errors(product.errors.full_messages)
            nil
          end
        end
      end
    end
  end
end