class Public::TagsController < ApplicationController
  def show
    @posts = Post.all
    # タグ一覧を取得
    @tags = Post.tag_counts_on(:tags)

    # パラメータからタグ名を取得
    tag_name = params[:id]

    # タグ名に基づいてタグに関連する情報を取得（例：タグが付けられた投稿）
    @tag = ActsAsTaggableOn::Tag.find_by(name: tag_name)

    # 特定のタグに関連付けられた投稿を取得
    @tagged_posts = Post.tagged_with(tag_name)

    # ページネーションのために、特定のタグに関連付けられた投稿の総数を計算
    @total_posts_count = @tagged_posts.count

    # ページネーションを適用し、1ページあたり12件の投稿を表示
    @tagged_posts = @tagged_posts.page(params[:page]).per(12)

    # タグの一覧ページを表示するビューテンプレートをレンダリング
    render 'show'
  end
end