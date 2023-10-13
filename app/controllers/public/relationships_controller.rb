class Public::RelationshipsController < ApplicationController
  before_action :authenticate_member!, except: [:top, :admin]
  
  def create
    member = Member.find(params[:member_id])
    current_member.follow(member)
    redirect_to request.referer
  end
  
  def destroy
    member = Member.find(params[:member_id])
    current_member.unfollow(member)
    redirect_to request.referer
  end
  
  def followings
    member = Member.find(params[:member_id])
    @members = member.followings
  end
  
  def followers
    member = Member.find(params[:member_id])
    @member = member.followers
  end
end
