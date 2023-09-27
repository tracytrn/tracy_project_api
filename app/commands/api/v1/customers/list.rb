module Api
  module V1
    module Customers
      class List
        prepend SimpleCommand
        attr_reader :params
        include Pagination 
        def initialize(params)
          @params = params
        end
        
        def call
          users = (User.customer.filter_users(params))
          { success: true, result: users }
        rescue StandardError => e
          { success: false, errors: e.message }
        end
      end
    end
  end
end