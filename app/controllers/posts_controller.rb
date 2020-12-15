class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :destroy]

  def index
    @posts = Post.all.order("updated_at DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
  end

  def edit
    if permit_to_edit_and_delete?
    else
      redirect_to @post
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    if permit_to_edit_and_delete?
      @post.destroy
      redirect_to posts_path
    else
      redirect_to @post
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def permit_to_edit_and_delete?
    @post = Post.find(params[:id])
    @user_id = current_user.id

    if @post.user_id == @user_id
      true
    else
      false
    end
  end

end
