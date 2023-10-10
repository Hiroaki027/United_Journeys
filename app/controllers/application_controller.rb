class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name,:first_name,:nick_name,:residence])
  end #deviseでの初期parameterに追加で許可する項目をsanitizerメソッドにpremitする内容を記述
      #permit(:deviseでの処理名, keys: [許可したいキー(カラム名)])
end
