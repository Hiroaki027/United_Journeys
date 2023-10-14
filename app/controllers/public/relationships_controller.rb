class Public::RelationshipsController < ApplicationController
  before_action :authenticate_member!, except: [:top, :admin]
  
  def create
    member = Member.find(params[:member_id]) #Memberモデルからmember_idを1件検索
    current_member.follow(member) #ログインメンバーがfollowメソッドを使う為(Memberモデル内に定義) = フォローする
    redirect_to request.referer
  end
  
  def destroy
    member = Member.find(params[:member_id])
    current_member.unfollow(member) ##ログインメンバーがunfollowメソッドを使う為(Memberモデル内に定義) = フォローを外す
    redirect_to request.referer
  end
  
  def followings
    member = Member.find(params[:member_id])
    @member = Member.find(params[:member_id])
    @members = member.followings
  end
  
  def followers
    member = Member.find(params[:member_id])
    @member = Member.find(params[:member_id])
    @members = member.followers
  end
end
