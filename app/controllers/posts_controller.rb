class PostsController < ApplicationController
  include ApplicationHelper
  before_action :signed_in, only: [:create, :new, :show]
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
  end

  def index
    @posts = Post.all
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def signed_in
    unless logged_in?
      flash[:error] = "you must be signed in to see that page!"
      redirect_to login_path
    end
  end
end
