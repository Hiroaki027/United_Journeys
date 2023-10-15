class Public::CommentsController < ApplicationController
  before_action :authenticate_member!, except: [:top, :admin]
  def create
    @post = Post.find(params[:post_id])
    comment = current_member.comments.new(comment_params)
    comment.post_id = @post.id
    comment.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    comment = @post.comments.find(params[:id])
    comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end