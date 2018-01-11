class CommentsController < ApplicationController
  def create
    comment = Comment.new(comments_params)
    comment.user = current_user
    if comment.save
      flash[:success] = "Comment was created"
      right_redirect(comment)
    else
      flash[:error] = "Something was wrong"
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    render partial: 'comments/form', locals: { resource: @comment.commentable,
                                               comment: @comment}
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comments_params)
      flash[:success] = "Comment was updated"
      right_redirect(@comment)
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

  def right_redirect(comment)
    if root_post_for(comment).class == Post
      redirect_to post_path(root_post_for(comment))
    else
      redirect_to event_path(root_post_for(comment))
    end
  end

  def comments_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id)
  end
end
