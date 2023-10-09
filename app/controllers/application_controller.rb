class ApplicationController < ActionController::Base
before_action :authenticate_member!, except: [:top] #ユーザーがログインしているかどうか確認する
before_action :configure_permitted_parameters, if: :devise_controller?
    
  def after_sign_in_path_for(resource)
    member_path(current_member)
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name,:first_name,:nick_name,:residence])
  end #deviseでの初期parameterに追加で許可する項目をsanitizerメソッドにpremitする内容を記述
      #permit(:deviseでの処理名, keys: [許可したいキー(カラム名)])
end
