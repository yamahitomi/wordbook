class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception

  def logged_in_user
    unless logged_in?
      flash[:danger] = "ログインしてください"
      redirect_to login_path
    end
  end
end
