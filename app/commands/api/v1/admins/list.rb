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
          users = User.admin.filter_users(params)
          users = users.page(page).per(per_page)
          { 
            success: true, 
            records: users.map { |user| UserPresenter.new(user).json_response },
            pagy: pagination(users)
          }
        rescue StandardError => e
          { success: false, errors: e.message }
        end
      end
    end
  end
end