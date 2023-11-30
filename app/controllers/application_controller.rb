class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name,:first_name,:nick_name,:residence])
  end #deviseでの初期parameterに追加で許可する項目をsanitizerメソッドにpremitする内容を記述
      #permit(:deviseでの処理名, keys: [許可したいキー(カラム名)])

  def ensure_member
    @member = Member.find(params[:id])
    unless @member == current_member
      redirect_to member_path(current_member) , notice: "ログイン会員以外は他の編集画面へ遷移できません。"
    end
  end

  def public_post
    @post = Post.find(params[:id])
    unless  @post.public_flag == "public"
      redirect_to posts_path, notice: "ログイン会員以外は他の非公開投稿画面へ遷移できません。"
    end
  end
end
