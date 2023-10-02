module Api
  module V1
    module Categories
      class Create
        prepend SimpleCommand
        attr_reader :params, :current_user

        def initialize(params, current_user)
          @params = params
          @current_user = current_user
        end

        def call
          category = Category.new(category_params)

          if category.save
            CategoryPresenter.new(category).json_response
          else
            errors.add_multiple_errors(category.errors.full_messages)
            nil
          end
        end

        private

        def category_params
          permitted_params = params.permit(:name, :description, :thumbnail)
          
          # Check if the current user is an admin
          if current_user&.admin?
            permitted_params[:user_id] = current_user.id
          end

          permitted_params
        end
      end
    end
  end
end

      