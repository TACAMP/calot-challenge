class SearchesController < ApplicationController

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == 'User'
      @users = User.looks(params[:word]).page(params[:page]).per(10).order(created_at: :desc)
    elsif @range == 'Post'
      @posts = Post.looks(params[:word]).page(params[:page]).per(5).order(created_at: :desc)
    else
      @tags = Tag.looks(params[:word]).page(params[:page]).per(3)
    end
  end

end

