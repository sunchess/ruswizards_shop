class CategoriesController < ApplicationController
  before_action :category_params, only: [:create, :update]

  def index
    render json: Category.all.includes(:products).as_json(include: [:products])
  end

  def create

  end

  def update
  end

  def destroy
  end

  private
    def category_params
      @category_params = params[:category].permit(:title)
    end
end
