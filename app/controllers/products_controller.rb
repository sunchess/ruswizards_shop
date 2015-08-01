class ProductsController < ApplicationController
  before_action :set_product, only: [:update, :destroy]
  before_action :check_rule, except: [:index, :show]

  skip_before_action :user_needed, only: [:index, :show]

  # GET /products
  # GET /products.json
  def index
    respond_to do |format|
      format.html
      format.json {
        if params[:filter]
          json_filter = JSON.parse(params[:filter])
          filter = Product.filter json_filter

          product_ids = Product.search_for_ids json_filter["query"], :per_page => 10000
          @products = Product.where(id: product_ids).where(filter)
        else
          @products = Product.all
        end

        render json: @products.includes(:category).as_json(include: [:category, :photo])
      }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    respond_to do |format|
      format.html {render "products/show"}
      format.json {
        product = Product.where(id: params[:id]).includes(:category).first
        render json: product.as_json(include: [:category, :photo])
      }
    end
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    render "products/edit"
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    if @product.save
      render json: {id: @product.id}
    else
      render json: {msg: @product.errors.full_messages.first}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    if @product.update(product_params)
      render json: {msg: "Товар успешно изменен", id: @product.id}
    else
      render json: {msg: @product.errors.full_messages.first}, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    render json: {}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.permit(:title, :description, :price, :photo, :category_id)
    end
end
