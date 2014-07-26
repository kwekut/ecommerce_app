class UsersController < ApplicationController

  before_action :signed_in_user, only: [:show, :edit, :update, :destroy, :index, :office]
  before_action :correct_user,   only: [:show, :edit, :update, :destroy, :office]
  before_action :admin_user,     only: [:destroy, :office]
  before_action :active_user,    only: :office

  # GET /users
  # GET /users.json
  def index # Used for list of favorites or followers/followings list
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json

  def show
    @user = User.find(params[:id])
    if @user.active?
      @shop = @user.shop
      render action: "active_show"
    end
  end

# def show
#   @book = Book.find(params[:id])
#   if @book.special?
#     render action: "special_show" and return
#   end
#   render action: "regular_show"
# end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :address, :phone, :password, :password_confirmation, :active)
    end
    # Used in place of set_user - default setup
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    # Admin access to edit shops
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end    
    # Only shop admin user can edit their shop
    def active_user
      redirect_to(root_url) unless current_user.active?
    end

end
