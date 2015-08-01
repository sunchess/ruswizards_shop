class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :user_needed, except: [:index]
  before_action :user_banned

  layout :false

  def index
    gon.categories = Category.all
    gon.user = {}

    if current_user
      gon.user = {
        info: current_user.as_json(only: [:fullname]),
        is_admin: current_user.has_role?(:admin)
      }

      if session[:users_products_ids]
        UsersProduct.where(id: session[:users_products_ids]).update_all({user_id: current_user.id})
        session[:users_products_ids] = nil
      end
    end
    
    render "layouts/application"
  end

  private
    def user_needed
      unless current_user
        render :json => {'msg' => 'Вы не авторизованы'}, :status => 401
      end
    end

    def user_banned
      if current_user && current_user.banned?
        render :json => {'msg' => 'Вы заблокированы'}, :status => 403
        sign_out current_user
      end
    end

    def check_rule
      unless current_user.is_admin?
        render json: {msg: "У вас нет прав на данное действие"}, status: 401
      end
    end
end
