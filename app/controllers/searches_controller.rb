class SearchesController < ApplicationController

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == 'User'
      @users = User.looks(params[:search],params[:word]).page(params[:page]).per(10)
    elsif @range == 'Post'
      @posts = Post.looks(params[:search],params[:word]).page(params[:page]).per(5)
    else
      @tags = Tag.looks(params[:search],params[:word]).page(params[:page]).per(3)
    end
  end

end

