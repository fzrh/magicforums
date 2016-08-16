class CommentsController < ApplicationController
  respond_to :js

  def index
    @post = Post.includes(:comments).find_by(id: params[:post_id])
    @topic = @post.topic
    @comments = @post.comments.order("created_at DESC")
    @comment = Comment.new
  end

  def create
    @post = Post.find_by(id: params[:post_id])
    @topic = @post.topic
    @comment = current_user.comments.build(comment_params.merge(post_id: params[:post_id]))
    @new_comment = Comment.new

    if @comment.save
      CommentBroadcastJob.set(wait: 0.1.seconds).perform_later("create", @comment)
      flash.now[:success] = "New comment added"
    else
      flash.now[:danger] = @comment.errors.full_messages
    end
  end

  def edit
    @post = Post.find_by(id: params[:post_id])
    @topic = @post.topic
    @comment = Comment.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:post_id])
    @topic = @post.topic
    @comment = Comment.find_by(id: params[:id])

    if @comment.update(comment_params)
      redirect_to topic_post_comments_path(@topic, @post)
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @post = @comment.post
    @topic = @comment.post.topic

    if @comment.destroy
      redirect_to topic_post_comments_path(@topic, @post)
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
