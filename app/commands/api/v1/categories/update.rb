module Api
  module V1
    module Categories
      class Update
        prepend SimpleCommand
        attr_reader :params, :current_user

        def initialize(params)
          @params = params
          @current_user = current_user
        end
      
        def call
          category = Category.find(params[:id])

          if current_user.admin?
            if category.update(category_params)
              CategoryPresenter.new(category).json_response
            else
              errors.add(:base, 'Category\'s information update failed.')
              nil
            end
          else
            errors.add(:base, 'Unauthorized to update this category\'s information.')
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