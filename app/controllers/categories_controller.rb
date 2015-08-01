class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]

  before_action :check_rule, except: [:index]

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
    respond_to do |format|
      format.json {
        category = Category.create(category_params)
        if category.valid?
          render json: {}
        else
          render json: {msg: category.errors.full_messages.first}, status: 400
        end
      }
    end
  end

  def edit
    render "categories/edit"
  end

  def show
    respond_to do |format|
      format.json {
        render json: @category
      }
    end
  end

  def update
    respond_to do |format|
      format.json {
        @category.update(category_params)
        render json: {msg: "Категория успешно обновлена"}
      }
    end
  end

  def destroy
    respond_to do |format|
      format.json {
        @category.destroy
        render json: {msg: "Категория успешно удалена"}
      }
    end
  end

  private
    def category_params
      params[:category].permit(:title, :discount_count, :discount_percent)
    end

    def set_category
      @category = Category.find_by id: params[:id]

      unless @category
        render json: {msg: "Категория не найдена"}, status: 404
      end
    end
end
