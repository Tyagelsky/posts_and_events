# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string
#  description :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#

class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy, :edit]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.create(post_params)
    if @post
      flash[:success] = "Post was successfuly saved"
      redirect_to posts_path
    else
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
