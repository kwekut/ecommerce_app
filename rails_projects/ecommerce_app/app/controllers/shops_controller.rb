class ShopsController < ApplicationController
#  before_action :set_shop, only: [:show, :edit, :update, :destroy]

  before_action :signed_in_user, only: [:new, :edit, :update, :destroy]
#  before_action :correct_user,   only: [:edit, :update, :destroy, :office]
  # GET /shops
  # GET /shops.json
  def index # the search page?
    @user = User.find(params[:user_id])
    @shop = @user.shop
  end

  # GET /shops/1
  # GET /shops/1.json
  def show
    @user = User.where('shop._id' => BSON::ObjectId.from_string(params[:id])).first
    @shop = User.where('shop._id' => BSON::ObjectId.from_string(params[:id]))
      .map do |s|  s.products.select { |p| p._id == BSON::ObjectId.from_string(params[:id]) } end.flatten    
  end

  # GET /shops/new
  def new
    @user = User.find(params[:user_id])
    @shop = @user.shop.build if signed_in?
  end

  # GET /shops/1/edit
  def edit
    @user = User.where('shop._id' => BSON::ObjectId.from_string(params[:id])).first
    @shop = @user.shop.select { |p| p._id == BSON::ObjectId.from_string(params[:id]) }
  end

  # POST /shops
  # POST /shops.json
  def create
    @user = User.find(params[:user_id])
    @shop = @user.shop.build(shop_params)

    respond_to do |format|
      if @shop.save
        format.html { redirect_to @shop, notice: 'Shop was successfully created.' }
        format.json { render :show, status: :created, location: @shop }
      else
        format.html { render :new }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shops/1
  # PATCH/PUT /shops/1.json
  def update
    @user = User.where('shop._id' => BSON::ObjectId.from_string(params[:id])).first
    @shop = @user.shop.select { |p| p._id == BSON::ObjectId.from_string(params[:id]) }

    respond_to do |format|
      if @shop.update_attributes(shop_params)
        format.html { redirect_to @shop, notice: 'Shop was successfully updated.' }
        format.json { render :show, status: :ok, location: @shop }
      else
        format.html { render :edit }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1
  # DELETE /shops/1.json
  def destroy
    @user = User.where('shop._id' => BSON::ObjectId.from_string(params[:id])).first
    @user.shop.delete_if {|p| p._id == BSON::ObjectId.from_string(params[:id]) }

    respond_to do |format|
      format.html { redirect_to shops_url, notice: 'Shop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop
      @shop = Shop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_params
      params.require(:shop).permit(:shop_title, :shop_info, :shop_category, :shop_banner, :shop_about, :shop_hours, :shop_url, :shop_gallery, :shop_slug)
    end
end
