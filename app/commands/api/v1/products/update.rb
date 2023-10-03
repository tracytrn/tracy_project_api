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
          product = Product.find_by(id: params[:id])

          if product.update(product_params)
            productPresenter.new(product).json_response
          else
            errors.add(:base, 'Product\'s information update failed.')
            nil
          end
        end
      end
    end
  end
end