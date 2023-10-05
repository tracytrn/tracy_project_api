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
          
          records = load_products.page(page).per(per_page)
          { 
            success: true,
            records: records.map { |product| ProductPresenter.new(product).json_response },
            pagination: pagination(records)
          }
        rescue StandardError => e
          { success: false, errors: e.message }
        end

        private

        #Kane: using single query, example below:
        # def records
        #   @records ||= Product.includes(:categories).search_by_name(params[:keyword]).sorted_by_latest.page(page).per(per_page)
        # end

        def load_products
          Product.includes(:categories).search_by_name(params[:keyword]).sorted_by_latest
        end
      end
    end
  end
end