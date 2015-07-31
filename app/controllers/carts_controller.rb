class CartsController < ApplicationController
  def index
    is_not = params[:tab] == 'orders' ? 'NOT' : ''
    @products = current_user.products.includes(:category, :photos, :users_products).where("users_products.order_id IS #{is_not} NULL")
  end
  
  def create
    product = UsersProduct.where('order_id IS NULL').where(user_id: current_user.id, product_id: params[:id]).first_or_create
    product.count += params[:count]
    product.save
    render json: {msg: "Товары успешно добавлены в корзину"}
  end

  def reset
    params[:products].each do |product|
      product = UsersProduct.find_or_create_by user_id: current_user.id, product_id: product[:id], count: product[:count]
    end

    render json: {}
  end

  def destroy
    user_product = current_user.users_products.where(product_id: params[:id]).first
    if !user_product || !user_product.order_id
      product = Product.find_by(id: params[:id])
      current_user.products.delete product
      render json: {msg: "Товар успешно удален из корзины"}
    else
      render json: {msg: "Ошибка удаления из корзины"}, status: 500
    end
  end
end
