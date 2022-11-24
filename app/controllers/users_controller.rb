class UsersController < ApplicationController
  before_action :set_user , only:[:favorites]

  def show
    @user=User.where(id: params[:id])
    @user_post=User.find(params[:id])
    @post=@user_post.posts.page(params[:page]).per(5)
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path
    else
      render 'users/edit'
    end
  end

  #favorite一覧用メソッド
  def favorites
    favorites=Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts=Post.find(favorites)
  end

  private

  def user_params
    params.require(:user).permit(:name,:introduction,:user_image)
  end
  #favorite用のuserを探すメソッド
  def set_user
    @user = User.find(params[:id])
  end

end
