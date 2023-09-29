require 'delegate'
class CategoryPresenter < SimpleDelegator
  def json_response
    {
      id: id,
      name: name,
      description: description,
      thumbnail: thumbnail,
      user_id: user_id
    }
  end
end