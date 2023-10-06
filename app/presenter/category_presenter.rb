require 'delegate'
class CategoryPresenter < SimpleDelegator
  def json_response
    {
      id: id,
      name: name,
      description: description,
      thumbnail: thumbnail,
      sub_categories_detail: sub_categories_detail
    }
  end

  def sub_categories_detail
    sub_categories.map do |sub_category|
      {
        id: sub_category.id,
        name: sub_category.name
      }
    end
  end
end