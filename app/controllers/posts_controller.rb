class PostsController < ApplicationController
  before_action :require_login, only: [:create, :new, :show]
  before_action :require_own_post, only: [:destroy, :edit, :update]
  def new
    @post = Post.new
  end

  def edit
    @post = Post.find_by(id: params[:id])
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

  def update
    @post = Post.find_by(id: params[:id])
    if @post
      @post.update(post_params)
      flash[:error] = "Post updated"
      redirect_to @post
    else
      flash[:error] = "That post does not exist"
      redirect_to posts_path
    end
  end

  def destroy
    post = Post.find_by(id: params[:id])
    if post
      post.destroy
      flash[:success] = "Post Deleted!"
      redirect_to profile_path
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
