module Api
  module V1
    module Admins
      class List
        prepend SimpleCommand
        attr_reader :params
        include Pagination 
        def initialize(params)
          @params = params
        end
        
        def call
          records = load_users.page(page).per(per_page)
          { 
            success: true, 
            records: records.map { |user| UserPresenter.new(user).json_response },
            pagination: pagination(records)
          }
        rescue StandardError => e
          { success: false, errors: e.message }
        end

        private
        def load_users
          User.admin.search_by_name(params[:keyword]).sorted_by_newest
        end
      end
    end
  end
end