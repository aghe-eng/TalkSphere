class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy like unlike]
  before_action :authenticate_user!, except: %i[ show index]
  before_action :set_category

  # GET /posts or /posts.json
  def index
    @posts = @category.posts.order(created_at: :desc)
  end

  # GET /posts/1 or /posts/1.json
  def show
    # views = @post.views + 1
    # @post.views = views
    # @post.save
    @category = @post.category
    @comments = @post.comments.order(created_at: :desc)
    @post.update(views: @post.views + 1)
  end

  # GET /posts/new
  def new
    @post = @category.posts.build
  end

  # GET /posts/1/edit
    def edit
      unless current_user == @post.user
        redirect_to category_post_path(@category, @post), notice: "You are not authorized to edit this post."
      end
    end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to category_post_url(@category, @post), notice: "Post was successfully created."}
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to category_post_path(@category, @post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!
    @comment = @post.comments.find(params[:comment_id])
      unless current_user == @comment.user
        redirect_to category_post_path(@category, @post), notice: "You are not authorized to delete this comment."
      end
    respond_to do |format|
      format.html { redirect_to category_posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

 def like
  @post.likes.create(user_id: current_user.id)
  respond_to @category_post, notice: "Post liked!"
 end

 def unlike
  @post.likes.where(user_id: current_user.id).destroy_all
  respond_to @category_post, notice: "Post unliked!"
 end

  private

    def set_post
        @post = Post.find_by(id: params[:id])
        redirect_to(category_posts_path) unless @post
    end

    def set_category
      @category = Category.find(params[:category_id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :category_id)
    end

    def comment_params
      params.require(:comment).permit(:content, :user_id, :post_id)
    end
end
