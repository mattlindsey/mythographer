class StoryWritingAssistant < Langchain::Assistant
  attr_accessor :thread
  attr_reader :tools

  # @param llm [Langchain::LLM::Base] LLM instance that the assistant will use
  def initialize(llm)
    inst = <<~INST
      I am a writing assistant. 
      I can help you write stories and more. 
      And I can help you with research and questions about your story.
    INST

    thread = Langchain::Thread.new
    tools = [Langchain::Tool::Wikipedia.new]
    super(llm: llm, thread: thread, tools: tools, instructions: inst)
  end

  # Give the assistant a story to work with
  #
  # @param content [String] The content of the message
  def create_story_message(story:)
    add_message(content: "The story is: " + story, role: "user")
  end

  # Ask the writing assistant about the story
  def ask(question:)
    add_message_and_run(content: question, auto_tool_execution: true)
  end
end
