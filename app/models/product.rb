class Product < ApplicationRecord
  belongs_to :user
  has_many :categories, through: :product_categories
end
