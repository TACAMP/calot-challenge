class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:name].split(/[[:blank:]]+/)
    if @post.save
      @post.save_tag(tag_list)
      redirect_to root_path , notice: '投稿に成功しました。'
    else
      render 'new'
    end
  end

  def index
    @posts = Post.all
    @tag_list = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @post_tags = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path , notice: '投稿を削除しました。'
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :campsite_name, :campsite_address, :post_image)
  end

end
