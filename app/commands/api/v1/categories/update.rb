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
          category = Category.find_by(id: params[:id])

          if category.update(category_params)
            CategoryPresenter.new(category).json_response
          else
            errors.add(:base, 'Category\'s information update failed.')
            nil
          end
        end

        private
        def category_params
          # Permit both category and sub_categories attributes
          params.require(:category).permit(
            :name,
            :description,
            :user_id,
            sub_categories_attributes: [:name, :description]
          )
        end
      end
    end
  end
end