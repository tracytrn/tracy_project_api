require 'delegate'

class UserDecorator < SimpleDelegator
  def json_response
    {
      role: role,
      id: id,
      first_name: first_name,
      last_name: last_name
    }
  end
end