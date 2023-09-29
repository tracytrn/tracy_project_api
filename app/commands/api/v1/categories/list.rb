module Api
  module V1
    module Categories
      class List
        prepend SimpleCommand
        attr_reader :params
        include Pagination 
        def initialize(params)
          @params = params
        end
        
        def call
          categories = Category.filter_categories(params)
          categories = categories.page(page).per(per_page)
          { 
            success: true, 
            records: categories.map { |category| CategoryPresenter.new(category).json_response },
            pagination: pagination(categories)
          }
        rescue StandardError => e
          { success: false, errors: e.message }
        end
      end
    end
  end
end