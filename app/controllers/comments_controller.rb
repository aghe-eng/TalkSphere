class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post
  before_action :set_comment, only: [:edit, :update, :destroy]


  def edit
    unless current_user == @comment.user
      redirect_to category_post_path(@category, @post), notice: "You are not authorized to edit this comment."
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to category_post_path(@category, @post)
    else
      render 'edit'
    end
  end

  def create
    @comment = @post.comments.create(comment_params.merge(user: current_user))
    if @comment.save
      flash[:notice] = "comment has been created"
      redirect_to category_post_path(@category, @post)
    else
      flash[:alert] = "comment has not been created"
      redirect_to category_post_path(@category, @post)
    end
  end

  def destroy
    @comment.destroy
    redirect_to category_post_path(@category, @post), notice: 'Comment was successfully deleted.'
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
