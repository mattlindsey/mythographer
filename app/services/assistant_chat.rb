# require "dotenv/load"
# require "langchain"
# require "openai"
require "reline"

# gem install reline
# or add `gem "reline"` to your Gemfile

class AssistantChat
  attr_accessor :assistant

  DONE = %w[done end eof print exit].freeze

  def prompt_for_message
    puts "\n(multiline input; type 'end' on its own line when done. or 'print' to print messages, or 'exit' to exit)\n\n"

    user_message = Reline.readmultiline("Query: ", true) do |multiline_input|
      last = multiline_input.split.last
      DONE.include?(last)
    end

    return :noop unless user_message
    return :print if user_message == "print"

    lines = user_message.split("\n")

    if lines.size > 1 && DONE.include?(lines.last)
      # remove the "done" from the message
      user_message = lines[0..-2].join("\n")
    end

    return :exit if DONE.include?(user_message.downcase)

    user_message
  end

  def print_messages(assistant)
    puts "\n"
    assistant.messages.each do |message|
      puts "----"
      puts message.role + " role content: " + message.content
      case message.role
      when "assistant"
        message.tool_calls.each do |tool_call|
          puts " " + tool_call["function"]["name"] + ": " << tool_call["function"]["arguments"]
        end
      when "tool"
        puts " tool_call_id: " + message.tool_call_id
      end
    end
    puts "-------"
  end

  def run
    # llm = Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"])

    # Or use local Ollama. See https://ollama.com/search?c=tools for models that support tools.
    # llm = Langchain::LLM::Ollama.new(default_options: {chat_model: "mistral"})

    assistant = Langchain::Assistant.load(Assistant.first.id)

    puts "Welcome to your story writer assistant!"

    loop do
      user_message = prompt_for_message

      case user_message
      when :noop
        next
      when :print
        print_messages(assistant)
        next
      when :exit
        break
      end

      assistant.add_message_and_run content: user_message, auto_tool_execution: true
      assistant.save
      puts assistant.messages.last.content + "\n"
    end
  end
end
