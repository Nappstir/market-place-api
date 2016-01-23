class Api::V1::OrdersController < ApplicationController
  respond_to :json

  def index
    respond_with current_user.orders
  end

end
