module Api
  module V1
    module Categories
      class ListProducts
        prepend SimpleCommand
        attr_reader :params
        include Pagination

        def initialize(params)
          @params = params
        end

        def call
          category = Category.find_by(id: params[:id])

          if category
            products = category.products
            products
          else
            errors.add(:base, 'Category not found.')
            nil
          end
        end
      end
    end
  end
end
