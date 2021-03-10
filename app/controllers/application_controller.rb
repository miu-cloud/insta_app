class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper
    before_action :login_required
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
    private
    def login_required
        redirect_to new_session_path unless current_user
    end
end
