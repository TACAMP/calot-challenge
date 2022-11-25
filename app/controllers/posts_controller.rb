class PostsController < ApplicationController
  before_action :ensure_correct_user , only:([:edit,:update])


  def new
    @post = Post.new
    @camp_tools = @post.camp_tools.build
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:name].split(/[[:blank:]]+/)
    if @post.save
      @post.save_tag(tag_list)
      redirect_to root_path , success: "投稿に成功しました。"
    else
      render 'new'
    end
  end

  def index
    @posts = Post.where(user_id: [current_user.id, *current_user.following_ids]).page(params[:page]).per(5)
    @tag_list = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @post_tags = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(' ')
  end

  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    tag_list = params[:post][:name].split(/[[:blank:]]+/)
    if @post.update(post_params)
       @post.save_tag(tag_list)
      redirect_to post_path(@post) , success: '投稿の編集に成功しました。'
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path , success: '投稿を削除しました。'
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :campsite_name, :campsite_address, :post_image,
                                camp_tools_attributes:[:id, :post_id, :tool_name, :_destroy])
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    @user = @post.user
    unless @user == current_user
      redirect_to root_path
    end
  end

end
