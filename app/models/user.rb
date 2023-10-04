# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  first_name      :string           not null
#  last_name       :string           not null
#  password_digest :string           not null
#  role            :integer          default("customer"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_secure_password
  
  before_validation :downcase_email
  validates :email, uniqueness: true

  has_many :products
  has_many :categories
  
  enum role: {customer: 0, admin: 1}
  
  scope :search_by_name, ->(keyword) do 
    where('first_name ILIKE :key OR last_name ILIKE :key', key: "%#{keyword}%")
  end

  scope :sorted_by_newest, -> { order(created_at: :DESC) }

  def downcase_email
    self.email = email.downcase if email.present?
  end
end
