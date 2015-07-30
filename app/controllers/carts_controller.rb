class CartsController < ApplicationController
  def index
    @products = current_user.products.includes(:category, :photos, :users_products)
  end
  
  def create
    product = UsersProduct.find_or_create_by(user_id: current_user.id, product_id: params[:id])
    product.count += params[:count]
    product.save

    if current_user.save
      render json: {msg: "Товары успешно добавлены в корзину"}
    else
      render json: {msg: "Ошибка сохранения в корзину"}, status: 500
    end
  end

  def destroy
    current_user.products.delete Product.find_by(id: params[:id])

    if current_user.save
      render json: {msg: "Товар успешно удален из корзины"}
    else
      render json: {msg: "Ошибка удаления из корзины"}, status: 500
    end
  end
end
