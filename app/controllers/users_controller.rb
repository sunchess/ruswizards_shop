class UsersController < ApplicationController
  before_action :set_user, only: [:ban]
  before_action :check_rule, only: [:manage, :ban]

  def manage
    respond_to do |format|
      format.html
      format.json {
        render json: User.all.as_json(only: [:fullname, :banned, :id], methods: [:is_admin?])
      }
    end
  end

  def ban
    respond_to do |format|
      format.html
      format.json {
        if @user.is_admin?
          render json: {msg: "Нельзя заблокировать данного пользователя"}, status: 401
        else
          @user.update(banned: params[:banned])
          if params[:banned]
            render json: {msg: "Пользователь успешно заблокирован"}
          else
            render json: {msg: "Пользователь успешно разблокирован"}
          end
        end
      }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
