class Public::PostsController < ApplicationController
  def new
    @post = Post.new
    @post.save
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
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿を更新しました"
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title,:content,:language, post_images: [])
  end
end
