# == Schema Information
#
# Table name: categories
#
#  id               :bigint           not null, primary key
#  categorable_type :string
#  description      :text
#  name             :string           not null
#  thumbnail        :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  categorable_id   :integer
#  user_id          :bigint
#
# Indexes
#
#  index_categories_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Category < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :categorable, polymorphic: true, optional: true
  has_many :sub_categories, as: :categorable, class_name: 'Category', dependent: :destroy
  accepts_nested_attributes_for :sub_categories
  has_many :product_categories
  has_many :products, through: :product_categories

  scope :search_by_name, ->(keyword) { where('name ILIKE ?', "%#{keyword}%") }
  scope :sorted_by_latest, -> { order(created_at: :desc) }
end
