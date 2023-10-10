class Admin::MembersController < ApplicationController
  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
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
  
  private
  
  def member_params
    params.require(:member).permit(:last_name, :first_name, :nick_name, :email, :introduction, :residence, :is_deleted)
  end
end
