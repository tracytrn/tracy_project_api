module Api
  module V1
    module Categories
      class Delete
        prepend SimpleCommand
        attr_reader :params

        def initialize(params)
          @params = params
        end

        def call
          category = Category.find_by(id: params[:id])
          
          unless category
            errors.add(:base, 'Category not found.')
            return nil
          end

          if category.destroy
            'Category deleted successfully.'
          else
            errors.add_multiple_errors(category.errors.full_messages)
            nil
          end
        end
      end
    end
  end
end
