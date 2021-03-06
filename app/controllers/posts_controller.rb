class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[ new create edit update destroy]
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    authorize Post

    @posts = Post.drafts(false).ordered.with_authors.search(params[:query]).page params[:page]
  end

  # GET /posts/drafts
  def drafts
    authorize Post

    @posts = current_user.admin? ? Post.all : current_user.posts
    @posts = @posts.drafts.ordered.with_authors
  end

  # GET /posts/1 or /posts/1.json
  def show
    authorize @post
  end

  # GET /posts/new
  def new
    authorize Post

    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    authorize @post
  end

  # POST /posts or /posts.json
  def create
    authorize Post

    @post = Post.new(post_params)
    # @post.post_picture.attach(params[:post_picture])
    @post.author = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    authorize @post

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    authorize @post

    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :draft, :post_picture)
    end
end
