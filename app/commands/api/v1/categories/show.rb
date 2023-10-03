module Api
  module V1
    module Categories
      class Show
        prepend SimpleCommand
        attr_reader :params

        def initialize(params)
          @params = params
        end
        
        def call
          category = Category.find_by(id: params[:id])
          
          if category 
            CategoryPresenter.new(category).json_response
          else
            errors.add(:base, 'The category with this ID could not be found.')
            nil
          end
        end
      end
    end
  end
end