class StoryGodsController < ApplicationController
  before_action :get_story
  before_action :set_storygod, only: [:show, :edit, :update, :destroy]

  def index
    @storygods = @story.storygods
  end

  def show
  end

  def new
    @storygod = @story.storygods.build
  end

  def edit
  end

  def create
    @storygod = @story.storygods.build(storygod_params)
  end

  def update
  end

  def destroy
    @storygod.destroy
  end

  private

  def get_story
    @story = Story.find(params[:story_id])
  end

  def set_storygod
    @storygod = @story.storygods.find(params[:id])
  end

  def storygod_params
    params.require(:storygod).permit(:story_id)
  end
end
