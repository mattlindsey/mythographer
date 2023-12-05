class StoryCreateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    story = Story.find(args[0])
    mythology_name = story.mythology.name
    llm_name = args[1] || LLM_DEFAULTS[:llm]

    case llm_name
    when "openai"
      llm = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"], llm_options: {temperature: story.creativity_temp})
    when "google"
      llm = Langchain::LLM::GooglePalm.new(api_key: ENV["GOOGLE_PALM_API_KEY"]) # TODO: llm_options: {temperature: story.creativity_temp})
    else
      logger.error "Unknown LLM: #{llm_name}"
    end

    prompt = Langchain::Prompt::PromptTemplate.new(template: "Tell me a very short story from {mythology_name} mythology that would be appropriately titled {title}.", input_variables: ["mythology_name", "title"])
    prompt_text = prompt.format(mythology_name: mythology_name, title: story.title)
    story.update(body: llm.complete(prompt: prompt_text).completion)
  end
end
