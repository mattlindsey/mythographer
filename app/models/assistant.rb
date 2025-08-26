# frozen_string_literal: true

class Assistant < ActiveRecord::Base
has_many :messages, dependent: :destroy

  validates :name, presence: true

  # TODO: Validate tool_choice

  def llm
    Langchain::LLM::OpenAI.new(api_key: ENV["OPENAI_API_KEY"])
  end
end
