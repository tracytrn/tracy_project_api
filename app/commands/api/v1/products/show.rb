module Api
  module V1
    module Products
      class Show
        prepend SimpleCommand
        attr_reader :params

        def initialize(params)
          @params = params
        end
        
        def call
          product = Product.find_by(id: params[:id])
          
          if product 
            ProductPresenter.new(product).json_response
          else
            errors.add(:base, 'The product with this ID could not be found.')
            nil
          end
        end
      end
    end
  end
end