class Admin::UsersController < Admin::BaseAdminController
  before_filter :require_admin

  def index
      @users = User.all
  end

  def show
      @user = User.find(params[:id])
  end

  def new
      @user = User.new
  end

  def create
      @user = User.new(params[:user])

      if @user.save
          flash[:notice] = "New User registered!"
          redirect_back_or_default admin_users_url
      else
          render :action => :new
      end
  end

  def edit
      @user = User.find(params[:id])
  end

  def update
      @user = User.find(params[:id])
      if @user.update_attributes(params[:user])
          flash[:notice] = "User details updated!"
          redirect_to admin_users_url
      else
          render :action => :edit
      end
  end

  def destroy
      @user = User.find(params[:id])
      @user.destroy

      redirect_to admin_users_url
  end
end

