class Public::MembersController < ApplicationController
  def show
    @member = Member.find(params[:id])
  end

  def edit
  end

  def withdrawal
  end
  
  def member_params
    params.require(:member).permit(:last_name, :first_name, :nick_name, :email, :introduction, :residence)
  end

end
