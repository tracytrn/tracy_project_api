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
          category = Category.find(params[:id])
          errors.add(:base, 'No category found with this ID.') unless category
          category.destroy
          { message: 'Category deleted successfully' }
        end
      end
    end
  end
end