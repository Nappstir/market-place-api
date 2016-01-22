class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :created_at, :updated_at, :auth_token

# will embed product ids in json response
  embed :ids
  has_many :products
end
