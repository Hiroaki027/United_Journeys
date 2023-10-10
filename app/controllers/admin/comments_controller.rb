class Admin::CommentsController < ApplicationController
  
  def destroy
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:id])
    comment.destroy
    redirect_to admin_post_path(params[:post_id])
  end
end
