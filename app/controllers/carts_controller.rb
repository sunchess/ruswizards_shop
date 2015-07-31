class CartsController < ApplicationController

  skip_before_action :user_needed

  def index
    respond_to do |format|
      format.html
      format.json {
        if current_user
          render json: User.products_in_cart(user_id)
        else
          render json: User.products_in_cart(user_id, session[:users_products_ids])
        end
      }
    end

  end
  
  def create
    user_product = UsersProduct.create(user_id: user_id, product_id: params[:id], count: params[:count])
    unless current_user
      session[:users_products_ids] ||= []
      session[:users_products_ids] << user_product.id
      users_products_ids = session[:users_products_ids]
    else
      users_products_ids = nil
    end

    render json: User.products_in_cart(user_id, users_products_ids)
  end

  def destroy
    if current_user || session[:users_products_ids].include?(params[:id].to_i)
      UsersProduct.where(user_id: user_id).destroy(params[:id])
      render json: {msg: "Товар успешно удален из корзины", user_products: User.products_in_cart(user_id, session[:users_products_ids])}
    else
      render json: {msg: "Ошибка удаления товара"}, status: 401
    end
  end


  private
    def user_id
      current_user.id rescue 0
    end
end
