class StoryCreateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    story = Story.find(args[0])
    mythology_name = story.mythology.name
    instructions = story.instructions
    llm_name = story.llm_name

    case llm_name
    when "openai"
      llm = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"], llm_options: {temperature: story.creativity_temp})
    when "google"
      llm = Langchain::LLM::GooglePalm.new(api_key: ENV["GOOGLE_PALM_API_KEY"], default_options: {temperature: story.creativity_temp})
    else
      logger.error "Unknown LLM: #{llm_name}"
    end

    story_template = Langchain::Prompt.load_from_path(file_path: "app/prompts/story_create_template.yaml")
    prompt_text = story_template.format(mythology_name: mythology_name, title: story.title)

    role_template = Langchain::Prompt.load_from_path(file_path: "app/prompts/story_role_template.yaml")
    StoryGod.where(story_id: args[0]).each do |g|
      god_name = g.god.name
      role = g.role
      prompt_text += ' ' + role_template.format(god: god_name, role: role)
    end

    prompt_text = 'TODO: Fix this' unless prompt_text # TODO: story_create_job_spec.rb fails without this line
    if instructions
      prompt = prompt_text + ' Additional instructions for generating the story are ' + instructions
    end

    story.update(body: llm.complete(prompt: prompt).completion)
  end
end
