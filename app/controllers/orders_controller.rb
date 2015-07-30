class OrdersController < ApplicationController
  before_action :order_params

  def index
    render json: current_user.orders
  end

  def create
    order = current_user.orders.create(@order_params)
    if order.valid?
      current_user.users_products.update_all(order_id: order.id)
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
