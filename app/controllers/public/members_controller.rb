class Public::MembersController < ApplicationController
  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = current_member
  end
  
  def update
    @member = current_member
    if @member.update(member_params)
      flash[:notice] = "会員情報を変更しました。"
      redirect_to member_path(current_member)
    else
      flash[:notice] = "変更内容が正しくありません。"
      redirect_to edit_member_path
    end
  end

  def withdrawal
    @member = current_member
    @member.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を完了しました。ご利用ありがとうございました。"
    redirect_to root_path
  end
  
  def member_params
    params.require(:member).permit(:last_name, :first_name, :nick_name, :email, :introduction, :residence)
  end

end
