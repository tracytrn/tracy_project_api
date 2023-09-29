module Api
  module V1
    module Categories
      class Update
        prepend SimpleCommand
        attr_reader :params

        def initialize(params)
          @params = params
        end
      
        def call
          category = Category.find(params[:id])
          if category.update(category_params)
            CategoryPresenter.new(category).json_response
          else
            errors.add(:base, 'The category with this ID could not be found.')
            nil
          end
        end
      
        private
      
        def category_params
          params.permit(:user_id, :name, :description, :thumbnail)
        end
      end
    end
  end
end