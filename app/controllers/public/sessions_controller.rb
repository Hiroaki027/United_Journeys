# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  def guest_sign_in
    member = Member.guest
    sign_in member
    redirect_to member_path(member), notice: "ゲストでログインしました。"
  end
  
  def after_sign_in_path_for(resource)
    member_path(current_member)
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end
  
  protected
  
  def reject_member
    @member = Member.find_by(email: params[:member][:email])
    if @member
      if @member.valid_password?(params[:member][:password]) && (@member.is_deleted == true)
        flash.now[:notice] = "退会済みです。再度ご登録をしてご利用ください"
        redirect_to new_member_registration_path
      else
        flash.now[:notice] = "項目を入力してください"
      end
    else
      flash.now[:notice] = "該当するユーザーが見つかりません"
    end
  end
 
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
