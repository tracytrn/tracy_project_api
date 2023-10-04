module Api
  module V1
    module Admins
      class Show
        prepend SimpleCommand
        attr_reader :params

        def initialize(params)
          @params = params
        end
        
        def call
          user = User.find_by(id: params[:id])
          if user&.admin?
            UserPresenter.new(user).json_response
          else
            errors.add(:base, 'The admin with this ID could not be found.')
            nil
          end
        end
      end
    end
  end
end