class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper
    def authenticate_user
        if @current_user == nil
           flash[:notice] = t('notice.ログインしてください')
           redirect_to new_session_path
        end
    end

    def fobid_login_user
        if @current_user
          flash[:notice]="ログインしています"
          redirect_to user_show
        end
    end
end
