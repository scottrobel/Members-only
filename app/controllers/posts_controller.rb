class PostsController < ApplicationController
  include ApplicationHelper
  before_action :require_login, only: [:create, :new, :show]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    redirect_to posts_path unless @post
  end

  def index
    @posts = Post.all
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
