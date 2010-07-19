class UsersController < ApplicationController

    def index
        @users = User.all
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(params[:user])
        if @user.save
            flash[:notice] = "Account registered!"
            redirect_back_or_default account_url
        else
            render :action => :new
        end
    end

    def show
        @user = current_user
    end

    def edit
        @user = current_user
    end

    def update
      @user = current_user

      respond_to do |format|
    		if @user.update_attributes(params[:user])
      		flash[:notice] = 'Profile was successfully updated. Please login again.'
      		format.html { redirect_to(login_path) }
      		format.xml  { head :ok }
    		else
      		format.html { render :action => "edit" }
      		format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
    		end
    	end
    end
end

