class Public::MembersController < ApplicationController
  before_action :authenticate_member!, except: [:top, :admin]
  before_action :ensure_guest_user, only: [:edit] #下記に定義したensure_guest_userでurlからもeditへ遷移できないように制限

  def show
    @member = Member.find(params[:id])
    @posts = Post.all
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
      render :edit
    end
  end

  def withdrawal
    @member = current_member
    @member.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を完了しました。ご利用ありがとうございました。"
    redirect_to root_path
  end

  def favorites
    @member = Member.find(params[:id])
    favorites = Favorite.where(member_id: @member.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  private

  def member_params
    params.require(:member).permit(:last_name, :first_name, :nick_name, :email, :introduction, :residence)
  end


  def ensure_guest_user
    @member = Member.find(params[:id])
    if @member.guest_member?
      redirect_to member_path(current_member) , notice: "ゲスト会員はプロフィール編集画面へ遷移できません。"
    end
  end
end
