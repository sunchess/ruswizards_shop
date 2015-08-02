class CartsController < ApplicationController

  skip_before_action :user_needed
  before_action :check_cart_rule, only: [:create, :update]

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
    @user_product.update(count: @user_product.count + params[:count])

    session[:users_products_ids] << @user_product.id

    users_products_ids = current_user ? nil : session[:users_products_ids]

    render json: User.products_in_cart(user_id, users_products_ids)
  end

  def update
    user_product = UsersProduct.find_by(user_id: user_id, id: params[:product_id])
    user_product.update(count: params[:count])

    if params[:count] == 0
      session[:users_products_ids].delete params[:product_id]
    end

    users_products_ids = current_user ? nil : session[:users_products_ids]

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

    def check_cart_rule
      @user_product = UsersProduct.where(user_id: user_id, product_id: params[:product_id])
      session[:users_products_ids] ||= []

      if current_user || !@user_product.first || @user_product.first && session[:users_products_ids].include?(params[:product_id].to_i)
        @user_product = @user_product.first_or_create
      else
        render json: {msg: "У вас нет прав на это действие"}, status: 401
      end
    end
end
