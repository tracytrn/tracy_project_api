class Category < ApplicationRecord
  belongs_to :user
  has_many :products, through: :product_categories
end
