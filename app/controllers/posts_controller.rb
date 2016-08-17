class PostsController < ApplicationController
  def index
    @topic = Topic.includes(:posts).friendly.find(params[:topic_id])
    @posts = @topic.posts.order("created_at DESC")
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end

  def create
    @topic = Topic.friendly.find(params[:topic_id])
    @post = Post.new(post_params.merge(topic_id: params[:topic_id]))

    if @post.save
      redirect_to topic_posts_path(@topic)
    else
      redirect_to new_topic_post_path(@topic)
    end
  end

  def edit
    @post = Post.friendly.find(params[:id])
    @topic = @post.topic
  end

  def update
    @topic = @post.topic
    @post = Post.friendly.find(params[:id])

    if @post.update(post_params)
      redirect_to topic_posts_path(@topic)
    else
      redirect_to edit_topic_post_path(@topic, @post)
    end
  end

  def destroy
    @post = Post.friendly.find(params[:id])
    @topic = @post.topic

    if @post.destroy
      redirect_to topic_posts_path(@topic)
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :body, :image)
    end
end
