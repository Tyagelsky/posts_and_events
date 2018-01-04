# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text
#  post_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#  index_comments_on_user_id  (user_id)
#

class CommentsController < ApplicationController
  before_action :find_post, only: [:create, :edit, :update, :destroy]
  before_action :find_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @post.comments.build(comments_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Comment was created"
      redirect_to user_path(@post.user)
    else
      flash[:notice] = "Something was wrong"
    end
  end

  def edit
  end

  def update
    if @comment.update(comments_params)
      flash[:success] = "Comment was updated"
      redirect_to user_path(@post.user)
    else
      flash[:notice] = "Something was wrong"
      render :edit
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = "Comment was successfuly deleted"
    redirect_to user_path(@post.user)
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = @post.comments.find(params[:id])
  end

  def comments_params
    params.require(:comment).permit(:body)
  end
end
