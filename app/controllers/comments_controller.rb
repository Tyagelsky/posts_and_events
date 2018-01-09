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
  # before_action :find_post, only: [:edit, :update, :destroy]

  def create
    comment = Comment.new(comments_params)
    comment.user = current_user
    if comment.save
      flash[:success] = "Comment was created"
      if root_post_for(comment) == Post
        redirect_to post_path(root_post_for(comment))
      else
        redirect_to event_path(root_post_for(comment))
      end
    else
      flash[:error] = "Something was wrong"
    end
  end

  def edit
    @comment = Comment.second
    byebug

    render partial: 'comments/form', locals: { new_comment: @comment, resource: @comment.commentable }
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comments_params)
      flash[:success] = "Comment was updated"
      redirect_to post_path(root_post_for(comment))
    else
      flash[:notice] = "Something was wrong"
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    head :no_content if @comment.destroy
  end

  private

  def root_post_for(resource)
    parent = resource.commentable
    return parent if parent.class.eql?(Post) || parent.class.eql?(Event)
    root_post_for(parent)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = @post.comments.find(params[:id])
  end

  def comments_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id)
  end
end
