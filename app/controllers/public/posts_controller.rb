class Public::PostsController < ApplicationController
  before_action :authenticate_member!, except: [:top, :admin]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to posts_path
    else
      @member = current_member
      render :new
    end
  end

  def index
    @post = Post.new
    @posts = Post.all
    @member = current_member
    @tags = @post.tag_counts_on(:tags)
  end

  def edit
    @post = Post.find(params[:id])
    @member = @post.member
  end

  def show
    @post = Post.find(params[:id])
    @member = @post.member
    @post_new = Post.new
    @comment = Comment.new
    @tags = @post.tag_counts_on(:tags)
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿を更新しました"
      redirect_to post_path(@post.id)
    else
      render :edit
    end
    if params[:post][:image_ids]
      params[:post][:image_ids].each do |image_id|
        image = @post.post_images.find(image_id)
        image.purge
      end
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end
  
  def search
    @posts = Post.looks(params[:search],params[:word])
  end

  private

  def post_params
    params.require(:post).permit(:title,:content,:language,:tag_list, post_images: [])
  end
end
