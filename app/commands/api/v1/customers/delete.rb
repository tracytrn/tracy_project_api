module Api
  module V1
    module Customers
      class Delete
        prepend SimpleCommand
        attr_reader :params

        def initialize(params)
          @params = params
        end
        
        def call
          user = User.find(params[:id])
          errors.add(:base, 'No user found with this ID.') unless user
          user.destroy
          { message: 'Account deleted successfully' }
        end
      end
    end
  end
end