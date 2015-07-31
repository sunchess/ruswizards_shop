class CategoriesController < ApplicationController
  before_action :category_params, only: [:create, :update]

  def index
    respond_to do |format|
      format.html
      format.json {
        if params[:with_products]
          render json: Category.all.includes(:products).as_json(include: [:products])
        else
          render json: Category.all
        end
      }
    end
  end

  def create
    category = Category.create(@category_params)
    if category.valid?
      render json: {}
    else
      render json: {msg: category.errors.full_messages.first}, status: 400
    end
  end

  def update
  end

  def destroy
  end

  private
    def category_params
      @category_params = params[:category].permit(:title, :discount_count, :discount_procent)
    end
end
