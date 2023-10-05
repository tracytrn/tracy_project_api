require 'delegate'
class ProductPresenter < SimpleDelegator
  def json_response
    {
      id: id,
      name: name,
      price: price,
      quantity: quantity,
      description: description,
      thumbnail: thumbnail,
      user_id: user_id,
      categories_detail: categories_detail
    }
  end

  def categories_detail
    categories.map do |category|
      {
        id: category.id,
        name: category.name
      }
    end
  end
end