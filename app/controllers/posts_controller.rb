class PostsController < ApplicationController
  def index
    @posts = Post.order(id: :asc)
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end