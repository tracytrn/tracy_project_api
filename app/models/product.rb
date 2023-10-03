class Product < ApplicationRecord
  belongs_to :user
  has_many :categories, through: :product_categories

  scope :search_by_name, ->(keyword) do
    where('name ILIKE ?', "%#{keyword}%")
  end

  scope :sorted_by_latest, -> { order(created_at: :DESC) }

  def self.filter_products(params)
    products = Products.all
    products = products.search_by_name(params[:keyword]) if params[:keyword].present?
    products = products.sorted_by_latest
    products
  end
end
