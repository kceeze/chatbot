class ApplicationController < ActionController::Base

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def require_signin
        unless current_user
            redirect_to signin_path, alert: "Please sign in"
        end
    end

    helper_method :current_user
end
