class User < ApplicationRecord
  has_secure_password

  has_many :products, dependent: :destroy
  has_many :categories, dependent: :destroy
  
  enum role: {customer: 0, admin: 1}
  
  scope :search_by_name, ->(search_key) do
    where('first_name ILIKE :key OR last_name ILIKE :key', key: "%#{search_key}%")
  end

  scope :sorted_by_first_name, -> { order(first_name: :ASC) }

  def self.filter_users(params)
    users = all
    users = users.where(role: params[:role]) if params[:role].present?
    users = users.search_by_name(params[:search_key]) if params[:search_key].present?
    users = users.sorted_by_first_name
    users
  end

  def json_response
    decorator.json_response
  end
  
  def decorator
    @decorator ||= UserDecorator.new(self)
  end
end
