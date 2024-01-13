class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy]

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
    @story = Story.new(storygods: [StoryGod.new])
  end

  def edit
  end

  def create
    @story = Story.new(story_params)
    @story.body = "Generating. Story should appear here. Wait a bit..."

    if @story.save
      llm_name = LLM_DEFAULTS[:llm] # TODO: get llm_name from params
      StoryCreateJob.perform_later(@story.id, llm_name)
      redirect_to @story
    else
      @mythologies = Mythology.all
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @story.update(story_params)
      redirect_to stories_path, notice: "Story was successfully updated."
    else
      render :show
    end
  end

  def destroy
    @story.destroy
    redirect_to stories_path, notice: "Story was successfully destroyed."
  end

  private

  def set_story
    @story = Story.find(params[:id])
  end

  def story_params
    params.require(:story).permit(:title, :mythology_id, :body, :creativity,
      storygods_attributes: [:god_id, :role, :_destroy])
  end
end
