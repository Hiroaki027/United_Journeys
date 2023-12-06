class Public::MembersController < ApplicationController
  before_action :authenticate_member!, except: [:top, :admin]
  before_action :ensure_guest_member, only: [:edit] #下記に定義したensure_guest_userでurlからもeditへ遷移できないように制限
  before_action :ensure_member, only: [:edit]
  before_action :public_post, only: [:show]

  def show
    @member = Member.find(params[:id])
    @posts = Post.all
    @public_posts = @member.posts.where(public_flag: "public") #公開用 
    @draft_posts = @member.posts.where(public_flag: "draft") #下書き用
    @private_posts = @member.posts.where(public_flag: "private") #非公開用
  end

  def index
    @members = Member.all
  end

  def edit
    @member = current_member
  end

  def update
    @member = current_member
    if @member.update(member_params)
      redirect_to member_path(current_member), notice: "会員情報を変更しました。"
    else
      flash.now[:alert] = "会員情報の変更に失敗しました"
      render :edit
    end
  end

  def withdrawal
    @member = current_member
    @member.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: "退会処理を完了しました。ご利用ありがとうございました。"
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


  def ensure_guest_member
    @member = Member.find(params[:id])
    if @member.guest_member?
      redirect_to member_path(current_member), notice: "ゲスト会員はプロフィール編集画面へ遷移できません。"
    end
  end
end
