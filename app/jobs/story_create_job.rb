class StoryCreateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    story = Story.find(args[0])
    mythology_name = Mythology.find(story.mythology_id).name
    llm_name = LLM_DEFAULTS[:llm]  # TODO: get from a dropdown

    if llm_name == "openai"
      llm = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"], llm_options: {temperature: story.creativity_temp})
    else
      logger.error "Unknown LLM: #{llm_name}"
    end

    prompt = Langchain::Prompt::PromptTemplate.new(template: "Tell me a very short story from {mythology_name} mythology that would be appropriately titled {title}.", input_variables: ["mythology_name", "title"])
    prompt_text = prompt.format(mythology_name: mythology_name, title: story.title)
    story.body = llm.complete(prompt: prompt_text).completion
    story.save
  end
end
