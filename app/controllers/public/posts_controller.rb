class Public::PostsController < ApplicationController
  before_action :authenticate_member!, except: [:top, :admin]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id

    if params[:draft].present?
      @post.public_flag = :draft
    else
      @post.public_flag = :public
    end

    if @post.save
      if @post.draft?
        redirect_to member_path(current_member), notice: "下書きが保存されました"
      else
        redirect_to posts_path, notice: "投稿が公開されました"
      end
    else
      flash.now[:alert] = "投稿の作成に失敗しました"
      render :new
    end
  end

  def index
    @post = Post.new
    @posts = Post.all
    @member = current_member
    @public_posts = @posts.where(public_flag: "public")
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
    if params[:draft].present?
      @post.public_flag = :draft
      notice_message = "下書きを保存しました"
      redirect_path = post_path(@post)
    elsif params[:private].present?
      @post.public_flag = :private
      notice_message = "非公開にしました"
      redirect_path = member_path(current_member)
    else
      @post.public_flag = :public
      notice_message = "投稿を更新しました"
      redirect_path = posts_path
    end

    if @post.update(post_params)
      redirect_to redirect_path, notice: notice_message
    else
      flash.now[:alert] = "投稿の更新に失敗しました"
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
    redirect_to member_path(current_member), notice: "投稿を削除しました"
  end

  def search
    @posts = Post.looks(params[:search],params[:word])
  end

  private

  def post_params
    params.require(:post).permit(:title,:content,:language,:tag_list,:public_flag, post_images: [])
  end
end