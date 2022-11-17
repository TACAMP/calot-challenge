class TagsController < ApplicationController

  def show
    @tag = Tag.find(params[:id])
    @post = @tag.posts
  end

end
