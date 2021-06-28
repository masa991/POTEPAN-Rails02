class ApplicationController < ActionController::Base
  before_action :set_search
  protect_from_forgery with: :exception
  #deviseコントローラーにストロングパラメータを追加する
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction, :image])
  end

  def after_sign_up_path_for(resource)
    profile_user_path
  end
  
  def after_sign_in_path_for(resource)
    :users
  end

  def after_sign_out_path_for(resource)
    :users
  end

  

  private
    def sign_in_required
      redirect_to new_user_session_url unless user_signed_in?
    end
  
   

  def set_search
    @q = Room.ransack(params[:q])
    @rooms = @q.result(distinct: true)
  end
end
