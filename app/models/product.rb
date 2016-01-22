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

  def self.search(params = {})
    # If product_id provided
    products = params[:product_ids].present? ? Product.find(params[:product_ids]) : Product.all

    # If product title provided
    products = products.filter_by_titles(params[:keyword]) if params[:keyword]

    # If product above_price provided
    products = products.above_or_equal_to_price(params[:min_price].to_f) if params[:min_price]

    # If product below_price provided
    products = products.below_or_equal_to_price(params[:max_price].to_f) if params[:max_price]

    # If product recent provided
    products = products.recent(params[:recent]) if params[:recent].present?

    products
  end

end
