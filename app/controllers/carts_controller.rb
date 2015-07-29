class CartsController < ApplicationController
  def create
    params[:product_ids].each do |product_id|
      current_user.products << Product.find_by(id: product_id)
    end

    if current_user.save
      render json: {msg: "Товары успешно добавлены в корзину"}
    else
      render json: {msg: "Ошибка сохранения в корзину"}, status: 500
    end
  end

  def destroy
    current_user.products.delete Product.find_by(id: params[:product_id])

    if current_user.save
      render json: {msg: "Товар успешно удален из корзины"}
    else
      render json: {msg: "Ошибка удаления из корзины"}, status: 500
    end
  end
end
