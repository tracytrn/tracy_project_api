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
          return nil unless current_user.admin?

          category = create_category
          return CategoryPresenter.new(category).json_response if category.persisted?

          errors.add_multiple_errors(category.errors.full_messages)
          nil
        end

        private

        def create_category
          category = Category.new(category_params)
          category.user_id = current_user.id
          assign_user_id_to_sub_categories(category)
          
          category if category.save
        end

        def assign_user_id_to_sub_categories(category)
          category.sub_categories.each do |sub_category|
            sub_category.user_id = current_user.id
          end
        end

        def category_params
          params.permit(:name, :description, sub_categories_attributes: [:name, :description])
        end
      end
    end
  end
end
