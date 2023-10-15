class Admin::MembersController < ApplicationController
  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
  end
  
  def update
    @member =  Member.find(params[:id])
    @member.update(member_params)
    flash[:notice] = "会員情報を変更しました。"
    redirect_to admin_members_path
  end
  
  private
  
  def member_params
    params.require(:member).permit(:last_name, :first_name, :nick_name, :email, :introduction, :residence, :is_deleted)
  end
end
