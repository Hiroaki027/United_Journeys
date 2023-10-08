class Public::PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def edit
  end

  def show
  end
end
