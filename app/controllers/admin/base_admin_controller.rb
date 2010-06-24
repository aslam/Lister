class Admin::BaseAdminController < ApplicationController
    include ApplicationHelper
    layout 'admin'

    helper_method :current_admin_session, :current_admin
    before_filter :require_admin

    private
    def current_admin_session
        return @current_admin_session if defined?(@current_admin_session)
        @current_admin_session = UserSession.find(:admin)
    end

    def current_admin
        return @current_admin if defined?(@current_admin)
        @current_admin = current_admin_session && current_admin_session.record
    end

    def require_admin
        unless current_admin && ["admin"].include?(current_admin.role)
            flash[:notice] = "You must be logged in to access this page!"
            redirect_to admin_login_url
            return false
        end
    end
end

