
class CommentsController < ApplicationController
  before_action :find_post

  def create
    @comment = @post.comments.create(comment_params.merge(user: current_user))
    redirect_to category_post_path(@category, @post)
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to category_post_path(@category, @post)
  end

  private

  def find_post
    @category = Category.find(params[:category_id])
    @post = @category.posts.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
