class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @member = @post.member
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end
  
end
