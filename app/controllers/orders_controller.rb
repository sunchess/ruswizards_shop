class OrdersController < ApplicationController
  before_action :order_params

  def index
    render json: current_user.orders
  end

  def create
    order = current_user.orders.create(@order_params)
    render json: {msg: "Заказ успешно создан", order: order}
  end

  private
    def order_params
      @order_params = params[:order].permit(:address, :phone, :fullname)
    end
end
