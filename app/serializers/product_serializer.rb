class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :price, :published

  # Will embed user as object when fetching product.
  has_one :user
end
