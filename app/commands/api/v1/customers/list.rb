module Api
  module V1
    module Customers
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
          User.customer.search_by_name(params[:keyword]).sorted_by_newest
        end
      end
    end
  end
end