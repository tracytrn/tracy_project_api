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

          category = update_category

          if category
            if category.errors.any?
              errors.add_multiple_errors(category.errors.full_messages)
              nil
            else
              CategoryPresenter.new(category).json_response
            end
          else
            nil
          end
        end

        private

        def update_category
          category = Category.find_by(id: params[:id])
          if category
            category.update(category_params)
          else
            errors.add(:base, 'No category found with this ID.')
          end

          category
        end

        def category_params
          params.permit(:name, :description, sub_categories_attributes: [:id , :name, :description])
        end
      end
    end
  end
end
