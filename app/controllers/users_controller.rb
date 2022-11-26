class UsersController < ApplicationController
  before_action :set_user , only:[:favorites]
  before_action :ensure_correct_user , only:[:edit]

  def show
    @user=User.where(id: params[:id])
    @user_post=User.find_by(name: params[:name])
    @post=@user_post.posts.page(params[:page]).per(5).order(created_at: :desc)
  end

  def edit
    @user=User.find_by(name: params[:name])
  end

  def update
    @user=User.find_by(name: params[:name])
    if @user.update(user_params)
      redirect_to user_path(@user.name) , success: 'ユーザー情報の編集に成功しました。'
    else
      render :edit
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
    @user = User.find_by(name: params[:name])
  end

  def ensure_correct_user
    @user = User.find_by(name: params[:name])
    unless @user == current_user
      redirect_to root_path
    end
  end

end
