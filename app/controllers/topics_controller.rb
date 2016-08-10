class TopicsController < ApplicationController
  def index
    @topics = Topic.all.order('created_at desc')
  end

  def new
    @topic = Topic.new
    authorize @topic
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      flash[:success] = "You've created a new topic."
      redirect_to topic_posts_path(@topic)
    else
      flash[:danger] = @topic.errors.full_messages
      redirect
    end
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update(topic_params)
      redirect_to topic_posts_path(@topic)
    else
      redirect_to :edit
    end
  end

  def destroy
    @topic = Topic.find_by(id: params[:id])
    if @topic.destroy
      redirect_to topics_path
    else
      redirect_to topic_posts_path(@topic)
    end
  end

  private
    def topic_params
      params.require(:topic).permit(:title, :description)
    end
end
