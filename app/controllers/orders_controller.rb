class OrdersController < ApplicationController
  before_action :order_params, only: [:create]

  def index
    render json: current_user.orders.includes(:products).includes(:orders_products).as_json(include: [:products, :orders_products], methods: [:price, :count])
  end

  def create
    order = current_user.orders.create @order_params
    orders_product = current_user.users_products.as_json(only: [:count, :product_id, :price])

    OrdersProduct.where(order_id: order.id).create(orders_product)

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
