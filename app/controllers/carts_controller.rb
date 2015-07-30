class CartsController < ApplicationController
  def index
    @products = current_user.products.includes(:category, :photos, :users_products)
    if params[:tab] == 'cart'
      @products = @products.where('users_products.order_id IS NULL')
    elsif params[:tab] == 'orders'
      @products = @products.where('users_products.order_id IS NOT NULL')
    end
  end
  
  def create
    product = UsersProduct.find_or_create_by(user_id: current_user.id, product_id: params[:id])
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
