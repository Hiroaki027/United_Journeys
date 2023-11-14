class Public::GroupsController < ApplicationController
  before_action :authenticate_member!, except: [:top, :admin]
  before_action :ensure_correct_member, only: [:edit, :update]
  
  def index
    @post = Post.new
    @groups = Group.all
  end
  
  def show
    @post = Post.new
    @group = Group.find(params[:id])
  end
  
  def join
    @group = Group.find(params[:group_id])
    @group.members << current_member
    redirect_to groups_path
  end
  
  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
    @group.owner_id = current_member.id
    if @group.save
      redirect_to groups_path
    else
      render "new"
    end
  end
  
  def edit
    
  end
  
  def update
    if @groups.update(group_params)
      redirect_to groups_path
    else
      render "edit"
    end
  end
  
  def destroy
    @group = Group.find(params[:id])
    @group.member.delete(current_member)
    redirect_to groups_path
  end
  
  private
  
  def group_params
    params.require(:group).permit(:name, :introduction)
  end
  
  def ensure_correct_member
    @group = Group.find(params[:id])
    unless @group.owner_id == current_member.id
      redirect_to groups_path
    end
  end
end
