class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    if params[:filter]
      json_filter = JSON.parse(params[:filter])
      filter = Product.filter json_filter

      product_ids = Product.search_for_ids json_filter["query"], :per_page => 10000
      @products = Product.where(id: product_ids).where(filter)
    else
      @products = Product.all
    end

    @products = @products.includes(:category, :photos)
  end

  def manage_catalog

  end

  # GET /products/1
  # GET /products/1.json
  def show
    respond_to do |format|
      format.html {render "products/show"}
      format.json {
        product = Product.where(id: params[:id]).includes(:category, :photos).first
        render json: product.as_json(include: [:category, :photos])
      }
    end
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :description)
    end
end
