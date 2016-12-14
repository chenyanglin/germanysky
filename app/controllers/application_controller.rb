class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    def current_user
    if session[:user_id] != nil
      @current_user = Account.find(session[:user_id]) if session[:user_id]
      if @current_user.role != 1
        @barcarts = @current_user.shoppingcarts
      end
    else
      @current_user = nil
    end
    #@current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end

  # def image_server
  #   @image_server = 

  # end

  # def API_current_user(email)
  #   @app_user ||= Account.find_by_email(email) if email
  # end

  # def API_beacon_check(uuid)
  #   @beacon ||= Beacon.find_by_beacon_uuid(uuid) if uuid
  # end
  #helper_method :current_user

  #在controller內進行驗證 若不是使用者 則無法任何controller使用功能


end
