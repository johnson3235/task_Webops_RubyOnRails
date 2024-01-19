# app/controllers/comment_controller.rb

class CommentController < ApplicationController
  before_action :authenticate_user
  before_action :set_comment, only: [:update_comment, :delete_comment]

  def get_all_comments
    comments = Comment.includes(:user, :post).where(user_id: current_user.id)
    render json: { comments: comments }
  end

  def add_comment
    post = Post.find_by(id: params[:post_id])

    if post
      comment = Comment.new(
        body: params[:body],
        user_id: current_user.id
      )

      post.comments << comment

      render json: { message: 'Comment added successfully' }, status: :created
    else
      render json: { error: 'Post not found' }, status: :not_found
    end
  end

  def update_comment
    authorize_comment_access

    @comment.update(body: params[:body])

    render json: { message: 'Comment updated successfully' }
  end

  def delete_comment
    authorize_comment_access

    @comment.destroy
    render json: { message: 'Comment deleted successfully' }
  end

  private

  def set_comment
    @comment = Comment.find_by(id: params[:id])

    render json: { error: 'Comment not found' }, status: :not_found unless @comment
  end

  def authorize_comment_access
    render json: { error: 'You do not have permission to perform this action' }, status: :forbidden unless current_user == @comment.user
  end
end
