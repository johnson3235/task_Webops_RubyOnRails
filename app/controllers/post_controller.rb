# app/controllers/post_controller.rb

class PostController < ApplicationController
  before_action :authenticate_user
  before_action :set_post, only: [:update_post, :delete_post]

  def get_all_posts
    posts = Post.includes(:tags, :comments)
    render json: { posts: posts }
  end

  def add_post
    tags = params[:tags].uniq

    post = current_user.posts.create(
      title: params[:title],
      body: params[:body]
    )

    tags.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      post.tags << tag
    end

    render json: { message: 'Post Created Successfully' }, status: :created
  end

  def update_post
    authorize_post_access

    @post.update(
      title: params[:title] || @post.title,
      body: params[:body] || @post.body
    )

    @post.tags.clear

    tags = params[:tags].uniq
    tags.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      @post.tags << tag
    end

    render json: { message: 'Post Updated Successfully' }
  end

  def delete_post
    authorize_post_access

    @post.destroy
    render json: { message: 'Post Deleted Successfully' }
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])

    render json: { error: 'Post not found' }, status: :not_found unless @post
  end

  def authorize_post_access
    render json: { error: 'You do not have permission to perform this action' }, status: :forbidden unless current_user == @post.user
  end
end
