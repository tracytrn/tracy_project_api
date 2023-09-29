class Category < ApplicationRecord
  belongs_to :user
  has_many :products, through: :product_categories

  scope :search_by_name, ->(keyword) do
    where('name ILIKE ?', "%#{keyword}%")
  end

  scope :sorted_by_latest, -> { order(created_at: :DESC) }

  def self.filter_categories(params)
    categories = Category.all
    categories = categories.search_by_name(params[:keyword]) if params[:keyword].present?
    categories = categories.sorted_by_latest
    categories
  end
end
