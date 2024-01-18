class StoryCreateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    story = Story.find(args[0])
    mythology_name = story.mythology.name
    llm_name = story.llm_name

    case llm_name
    when "openai"
      llm = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"], llm_options: {temperature: story.creativity_temp})
    when "google"
      llm = Langchain::LLM::GooglePalm.new(api_key: ENV["GOOGLE_PALM_API_KEY"], default_options: {temperature: story.creativity_temp})
    else
      logger.error "Unknown LLM: #{llm_name}"
    end

    template = Langchain::Prompt.load_from_path(file_path: "app/prompts/story_create_template.yaml")
    prompt_text = template.format(mythology_name: mythology_name, title: story.title)
    story.update(body: llm.complete(prompt: prompt_text).completion)
  end
end
