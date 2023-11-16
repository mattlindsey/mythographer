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
    llm = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"])

    # TODO: Get name from db instead of hardcoding
    if params[:story][:mythology_id].eql?('1') then m = 'Greek'
    elsif params[:story][:mythology_id].eql?('2') then m = 'Roman'
    elsif params[:story][:mythology_id].eql?('3') then m = 'Norse'
    end

    @story = Story.new(story_params)
    @story.body = "Generating..."

    if @story.save
      prompt = Langchain::Prompt::PromptTemplate.new(template: "Tell me a very short story from {mythology} mythology that would be appropriately titled {title}.", input_variables: ["mythology", "title"])
      prompt_text = prompt.format(mythology: m, title: @story.title)
      @story.body = llm.complete(prompt: prompt_text).completion
      @story.save

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