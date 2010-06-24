class Admin::AdminSessionsController < Admin::BaseAdminController
    skip_before_filter :require_admin
    before_filter :prepare_model, :except => [:destroy]

    def new
    end

    def create
        if @admin_session.save
            flash[:notice] = "Login successful"
            redirect_to admin_users_url
        else
            flash[:error] = "Invalid login"
            render :action => :new
        end
    end

    def destroy
        current_admin_session.destroy
        redirect_to admin_login_url
    end

    private
    def prepare_model
        params[:user_session] ||= {}

        @admin_session = UserSession.new(params[:user_session])
        @admin_session.id = :admin
    end
end

