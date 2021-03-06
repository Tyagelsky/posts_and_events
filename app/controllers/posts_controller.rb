class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy, :edit]

  def index
    @posts = Post.order(created_at: :desc).paginate(page: params[:page],
                                                  per_page: 5)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:success] = "Post was successfuly saved"
      redirect_to posts_path
    else
      flash[:error] = "Something was wrong"
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post was successfuly updated"
      redirect_to @post
    else
      flash[:error] = "Something was wrong"
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post was successfuly deleted"
    redirect_to posts_path
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:description, :title, :user_id)
    end
end
