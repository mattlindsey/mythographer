class StoryCreateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    llm = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"])

    story = Story.find(args[0])
    mythology_name = Mythology.find(story.mythology_id).name

    prompt = Langchain::Prompt::PromptTemplate.new(template: "Tell me a very short story from {mythology_name} mythology that would be appropriately titled {title}.", input_variables: ["mythology_name", "title"])
    prompt_text = prompt.format(mythology_name: mythology_name, title: story.title)
    story.body = llm.complete(prompt: prompt_text).completion

    story.save
  end
end
