class User < ApplicationRecord
  has_secure_password
  
  before_validation :downcase_email
  validates :email, uniqueness: true

  has_many :products, dependent: :destroy
  has_many :categories, dependent: :destroy
  
  enum role: {customer: 0, admin: 1}
  
  scope :search_by_name, ->(keyword) do
    where('first_name ILIKE :key OR last_name ILIKE :key', key: "%#{keyword}%")
  end

  scope :sorted_by_newest, -> { order(created_at: :DESC) }

  def self.filter_users(params)
    users = User.all
    users = users.where(role: params[:role]) if params[:role].present?
    users = users.search_by_name(params[:keyword]) if params[:keyword].present?
    users = users.sorted_by_newest
    users
  end

  def downcase_email
    self.email = email.downcase if email.present?
  end
end
