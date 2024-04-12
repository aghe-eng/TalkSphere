class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post
  before_action :set_comment, only: [:update, :destroy]


  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to category_post_url(@category, @post), notice: "Comment was successfully updated."}
      else
        format.html { redirect_to category_post_url(@category, @post), alert: "Comment could not been updated."}
      end
    end
  end

  def create
    @comment = @post.comments.new(comment_params.merge(user: current_user))
    if @comment.save
      flash[:notice] = "comment has been created"
      redirect_to category_post_path(@category, @post)
    else
      flash[:alert] = "comment has not been created"
      redirect_to category_post_path(@category, @post)
    end
  end

  def destroy
    if current_user == @comment.user
      # Create a notification before the comment is destroyed
      CommentDeletedNotifier.with(recipient: @post.user, actor: current_user, resource: @comment).deliver_later(@post.user)
      @comment.destroy
      flash[:notice] = 'Comment was successfully deleted.'
    else
      flash[:alert] = 'You are not authorized to delete this comment.'
    end
    redirect_to category_post_path(@category, @post)
  end
  
  private

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def find_post
    @category = Category.find(params[:category_id])
    @post = @category.posts.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
