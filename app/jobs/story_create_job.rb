class StoryCreateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    story = Story.find(args[0])

    llm = create_llm(story)
    return unless llm

    story_template = Langchain::Prompt.load_from_path(file_path: "app/prompts/story_create_template.yaml")
    prompt_text = story_template.format(mythology_name: story.mythology.name, title: story.title)

    role_template = Langchain::Prompt.load_from_path(file_path: "app/prompts/story_role_template.yaml")
    StoryGod.where(story_id: args[0]).find_each do |g|
      prompt_text += " " + role_template.format(god: g.god.name, role: g.role)
    end

    instructions = story.instructions
    if instructions
      prompt = prompt_text + " Additional instructions for generating the story are " + instructions
    end

    story.update(content: llm.complete(prompt: prompt).completion)
  end

  private

  def create_llm(story)
    case story.llm_name
    when "openai"
      Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"], llm_options: {temperature: story.creativity_temp})
    when "google"
      Langchain::LLM::GooglePalm.new(api_key: ENV["GOOGLE_PALM_API_KEY"], default_options: {temperature: story.creativity_temp})
    else
      logger.error "Unknown LLM: #{story.llm_name}"
      nil
    end
  end
end
