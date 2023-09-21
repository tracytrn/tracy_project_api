class User < ApplicationRecord
  enum role: {customer: 0, admin: 1}
  def self.filter_user_by(params)
    if params[:search_key].present?
      users = User.where('first_name ILIKE ?', "%#{params[:search_key]}")
                  .or(User.where('last_name ILIKE ?', "%#{params[:search_key]}"))
                  .order(first_name: :ASC)
    else
      users = User.order('first_name')
    end
  end
end
