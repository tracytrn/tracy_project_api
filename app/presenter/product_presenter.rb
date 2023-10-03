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
      user_id: user_id
    }
  end
end