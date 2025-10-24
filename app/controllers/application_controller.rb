class ApplicationController < ActionController::Base
  before_action :set_skip_header_footer
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_root_path
    when User
      mypage_public_users_path
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "ログアウトしました。"
    root_path
   end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private

  def set_skip_header_footer
    if (controller_name == "homes" && action_name == "top") ||
      devise_controller? ||
      controller_path == "admin/sessions"
      @skip_header_footer = true
    else
      @skip_header_footer = false
    end
  end
end
