class Product < ActiveRecord::Base
  validates :title, :user_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true

  belongs_to :user

  # scope :filter_by_titles, lambda { |keyword| where("lower(title) LIKE ?", "%#{keyword.downcase}") }
  def self.filter_by_titles(keyword)
    where("lower(title) LIKE ?", "%#{keyword.downcase}")
  end

  # scope  :above_or_equal_to_price, lambda { |price| where("price >= ?", price) }
  def self.above_or_equal_to_price(price)
    where("price >= ?", price)
  end

  def self.below_or_equal_to_price(price)
    where("price <= ?", price)
  end

  def self.recent
    order(:updated_at)
  end

end
