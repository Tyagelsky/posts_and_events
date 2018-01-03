class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy, :edit]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Post was successfuly saved"
      rediect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post was successfuly updated"
      rediect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post was successfuly deleted"
    rediect_to root_path
  end

  private
    def set_post
      @hall = Hall.find(params[:id])
    end

    def post_params
      params.permit(:description, :name, :user_id)
    end
end
