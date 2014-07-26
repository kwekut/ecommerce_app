class ProductsController < ApplicationController
#  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @user = User.find(params[:user_id])
    @products = @user.products
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @user = User.where('products._id' => BSON::ObjectId.from_string(params[:id])).first
    @product = User.where('products._id' => BSON::ObjectId.from_string(params[:id]))
      .map do |s|  s.products.select { |p| p._id == BSON::ObjectId.from_string(params[:id]) } end.flatten

  end

  # GET /products/new
  def new
    @user = User.find(params[:user_id])
    @product = @user.products.build if signed_in?
#    @shop_categories = @user.shop_category # for group select form
  end

  # GET /products/1/edit
  def edit
    @user = User.where('products._id' => BSON::ObjectId.from_string(params[:id])).first
    @product = @user.products.select { |p| p._id == BSON::ObjectId.from_string(params[:id]) }
#    @shop_categories = @user.shop_category # for group select form
  end

  # POST /products
  # POST /products.json
  def create
    @user = User.find(params[:user_id])
    @product = @user.products.build(product_params)

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
    @user = User.where('products._id' => BSON::ObjectId.from_string(params[:id])).first
    @product = @user.products.select { |p| p._id == BSON::ObjectId.from_string(params[:id]) }

    respond_to do |format|
      if @product.update_attributes(product_params)
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
    @user = User.where('products._id' => BSON::ObjectId.from_string(params[:id])).first
    @user.products.delete_if {|p| p._id == BSON::ObjectId.from_string(params[:id]) }
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:product_title, :product_info, :product_image, :product_price, :product_quantity, :product_quantity_ordered, :product_category)
    end
end

