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
          category = Category.new(category_params)

          if category.save
            CategoryPresenter.new(category).json_response
          else
            errors.add_multiple_errors(category.errors.full_messages)
            nil
          end
        end
      end
    end
  end
end

      