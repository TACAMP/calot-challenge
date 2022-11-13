class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to root_path , notice: '投稿に成功しました。'
    else
      render 'new'
    end
  end

  def index
    @posts = Post.all
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :campsite_name, :campsite_address, :post_image)
  end

end
