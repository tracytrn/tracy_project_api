module Api
  module V1
    module Categories
      class Create
        prepend SimpleCommand
        attr_reader :params

        def initialize(params)
          @params = params
        end

        def call
          category = create_category
          return CategoryPresenter.new(category).json_response if category.persisted?

          errors.add_multiple_errors(category.errors.full_messages)
          nil
        end

        private

        def create_category
          category = Category.new(category_params)
          category if category.save
        end

        def category_params
          params.permit(:name, :description, sub_categories_attributes: [:name, :description])
        end
      end
    end
  end
end
