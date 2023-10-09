class Public::CommentsController < ApplicationController
  def create
    @post_comment = Post.find(params[:post_id])
    @comment = current_member.comments.new(comment_params)
    @comment.post_id = @post_comment.id
    @post = Post.find(params[:post_id])
    unless @comment.save
      redirect_to 
    end
  end
end
