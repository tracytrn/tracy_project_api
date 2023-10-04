module Api
  module V1
    module Categories
      class List
        prepend SimpleCommand
        attr_reader :params, :current_user
        include Pagination 
        def initialize(params, current_user)
          @params = params
          @current_user = current_user
        end
        
        def call
          return nil unless current_user.admin?
          records = load_categories.page(page).per(per_page)
          { 
            success: true,
            records: records.map { |category| CategoryPresenter.new(category).json_response },
            pagination: pagination(records)
          }
        rescue StandardError => e
          { success: false, errors: e.message }
        end

        private
        def load_categories
          Category.includes(:sub_categories).search_by_name(params[:keyword]).sorted_by_latest
        end
      end
    end
  end
end