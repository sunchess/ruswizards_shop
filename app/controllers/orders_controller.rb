class OrdersController < ApplicationController
  before_action :order_params, only: [:create]

  def index
    render json: current_user.products_in_orders
  end

  def create
    order = current_user.orders.create @order_params
    current_user.users_products.each do |users_product|
      orders_product = users_product.slice(:count, :product_id)
      orders_product[:order_id] = order.id
      OrdersProduct.create(orders_product)
    end

    current_user.users_products.destroy_all

    if order.valid?
      render json: {msg: "Заказ успешно создан", order: order}
    else
      render json: {msg: order.errors.full_messages.first}, status: 500
    end
  end

  private
    def order_params
      @order_params = params[:order].permit(:address, :phone, :fullname)
    end
end
