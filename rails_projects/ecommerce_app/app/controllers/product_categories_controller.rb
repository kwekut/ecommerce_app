class ProductCategoriesController < ApplicationController
#  before_action :set_shop_category, only: [:new, :create]
#  before_action :set_product_category, only: [:show, :edit, :update, :destroy]
#  before_action :set_product_categories, only: [:index]
  # GET /product_categories
  # GET /product_categories.json
  def index
    @shop_category = ShopCategory.where('product_categories._id' => BSON::ObjectId.from_string(params[:id])).first
    @product_categories = @shop_categories.product_categories
  end

  # GET /product_categories/1
  # GET /product_categories/1.json
  def show
    
#    @product_category = ProductCategory.find(params[:id])
#    @product_category = ShopCategory.find("product_categories._id" => BSON::ObjectId.from_string(params[:id]))
#    @product_category = ShopCategory.find('product_categories._id' => params[:id])
    @shop_category = ShopCategory.where('product_categories._id' => BSON::ObjectId.from_string(params[:id])).first
#    @product_category = ShopCategory.product_categories.where(:_id => BSON::ObjectId.from_string(params[:id])).first
#    @product_category = ShopCategory.where('product_categories._id' => params[:id]).first
#    @product_categry = ShopCategory.all(:conditions => {'product_categories.id' => BSON::ObjectId.from_string(params[:id])})
#    @product_category = ShopCategory.find( { product_categories: {id: params[:id]} } )
#    @product_category = ShopCategory.find_by_product_categories_id(params[:id])
#    @product_variations = @product_category.product_variations
#    @product_options = @product_category.product_options
#    @product_category.product_categories.each { |key, value| shop_category_id = @value }
#    @shop_category = ShopCategory.find(:shop_category_id)

    @product_category = ShopCategory.where('product_categories._id' => BSON::ObjectId.from_string(params[:id]))
      .map do |sc|  sc.product_categories.select { |pc| pc._id == BSON::ObjectId.from_string(params[:id]) } end.flatten

  end

  # GET /product_categories/new
  def new
    @shop_category = ShopCategory.find(params[:shop_category_id])
    @product_category = @shop_category.product_categories.build if signed_in?
  end

  # GET /product_categories/1/edit
  def edit
    @shop_category = ShopCategory.where('product_categories._id' => BSON::ObjectId.from_string(params[:id])).first
#    @product_category = ProductCategory.find(params[:id])
    @product_category = @shop_category.product_categories.select { |pc| pc._id == BSON::ObjectId.from_string(params[:id]) }#.each { |b| b.address = new_address }
#    @product_category = ShopCategory.where('product_categories._id' => BSON::ObjectId.from_string(params[:id]))
#      .map do |sc|  sc.product_categories.select { |pc| pc._id == BSON::ObjectId.from_string(params[:id]) } end.flatten 
    @product_categories = @shop_category.product_categories

  end

  # POST /product_categories
  # POST /product_categories.json
  def create
    @shop_category = ShopCategory.find(params[:shop_category_id])
    @product_category = @shop_category.product_categories.build(product_category_params)
#    @product_category.shop_category = @shop_category

    respond_to do |format|
      if @product_category.save
        format.html { redirect_to @shop_category, notice: 'Product category was successfully created.' }
        format.json { render :show, status: :created, location: @product_category }
      else
        format.html { render :new }
        format.json { render json: @shop_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_categories/1
  # PATCH/PUT /product_categories/1.json
  def update
    @shop_category = ShopCategory.where('product_categories._id' => BSON::ObjectId.from_string(params[:id])).first
    @product_category = @shop_category.product_categories.select { |pc| pc._id == BSON::ObjectId.from_string(params[:id]) }
    respond_to do |format|
        @product_category.each do |product_category|
      if product_category.update_attributes(product_category_params)
        format.html { redirect_to @shop_category, notice: 'Product category was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_category }
      else
        format.html { render :edit }
        format.json { render json: @shop_category.errors, status: :unprocessable_entity }
      end
    end
    end
  end

  # DELETE /product_categories/1
  # DELETE /product_categories/1.json
  def destroy
    @shop_category = ShopCategory.where('product_categories._id' => BSON::ObjectId.from_string(params[:id])).first
#    @product_category = @shop_category.product_categories.select { |pc| pc._id == BSON::ObjectId.from_string(params[:id]) }
#    @product_category.clear
    @shop_category.product_categories.delete_if {|pc| pc._id == BSON::ObjectId.from_string(params[:id]) }
    respond_to do |format|
      format.html { redirect_to @shop_category, notice: 'Product category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_category_params
      params.require(:product_category).permit(:shop_category_id, :product_group, :product_subgroup, :product_type, 
        :product_gender, :other_product_category, :product_size, :product_box_size, :product_bottle_size, 
        :Product_pack_size, :product_service_time, :product_color, :other)
    end
end
