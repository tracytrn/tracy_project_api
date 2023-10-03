module Api
  module V1
    module Products
      class Delete
        prepend SimpleCommand
        attr_reader :params

        def initialize(params)
          @params = params
        end

        def call
          product = Product.find_by(id: params[:id])
          
          if product.destroy
            'Product deleted successfully.'
          else
            errors.add_multiple_errors(product.errors.full_messages)
            nil
          end
        end
      end
    end
  end
end