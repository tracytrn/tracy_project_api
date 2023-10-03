module Api
  module V1
    module Products
      class List
        prepend SimpleCommand
        attr_reader :params
        include Pagination 
        def initialize(params)
          @params = params
        end
        
        def call
          products = Category.filter_products(params)
          products = products.page(page).per(per_page)
          { 
            success: true, 
            records: products.map { |product| ProductPresenter.new(product).json_response },
            pagination: pagination(products)
          }
        rescue StandardError => e
          { success: false, errors: e.message }
        end
      end
    end
  end
end