class CommentsController < ApplicationController
  before_action :find_post, only: [:create, :destroy]
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    # @comment = @post.comments.create(comment_params)
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to @post
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    if permit_to_delete?
      @comment.destroy
    end
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :comment_text)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def permit_to_delete?
    @comment = @post.comments.find(params[:id])
    @user_id = current_user.id

    if @comment.user_id == @user_id
      true
    else
      false
    end
  end

end
