class StoriesController < ApplicationController
  def index 
    @stories = Story.all
  end

  def show
    @story = Story.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to stories_path
  end

  def new
    @mythologies = Mythology.all
    @story = Story.new
  end

  def create
    @story = Story.new(story_params)
    @story.body = "Generating... Refresh soon!"

    if @story.save
      StoryCreateJob.perform_later(@story.id)
      redirect_to @story
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def story_params
    params.require(:story).permit(:title, :mythology_id, :body)
  end
end