class RelationshipsController < ApplicationController

  def create
    @user = User.find_by(id: params[:user_name])
    current_user.follow(params[:user_name])
  end

  def destroy
    @user = User.find_by(id: params[:user_name])
    current_user.unfollow(params[:user_name])
  end

  def followings
    user = User.find_by(id: params[:user_name])
    @users = user.followings
  end

  def followers
    user = User.find_by(id: params[:user_name])
    @users = user.followers
  end

end
