class EnoughProductsValidator < ActiveModel::Validator

  def validate(order)
    order.placements.each do |placement|
      product = placement.product
      if placement.quantity > product.quantity
        order.errors["#{product.title}"] << "is out of stock, just #{product.quantity} left"
      end
    end
  end

end