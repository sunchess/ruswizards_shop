class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!, except: [:index]

  layout :false

  def index
    gon.categories = Category.all
    gon.user = {}
    
    if current_user
      gon.user = {
        info: current_user.as_json(only: [:fullname]),
        is_admin: current_user.has_role?(:admin)
      }
    end
    
    render "layouts/application"
  end
end
