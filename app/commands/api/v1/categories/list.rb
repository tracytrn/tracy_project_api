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
          # all method 
          records = categories.page(page).per_page(per_page)
          { 
            success: true,
            records: records.map { |category| CategoryPresenter.new(category).json_response },
            pagination: pagination(records)
          }
        rescue StandardError => e
          { success: false, errors: e.message }
        end

        def categories
          Category.includes(:categories).search_by_name(params[:keyword]).sorted_by_latest
        end

      end
    end
  end
end