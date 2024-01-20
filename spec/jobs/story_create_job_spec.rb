require "rails_helper"

RSpec.describe StoryCreateJob do
  include ActiveJob::TestHelper

  let(:story) { create(:story) }

  it "performs the job" do
    expect(described_class.new).to respond_to(:perform)
  end

  it "calls the StoryCreateJob with the correct args for openai" do
    allow(Story).to receive(:find).and_return(story)
    llm = instance_double(Langchain::LLM::OpenAI)
    llm_response = instance_double(Langchain::LLM::OpenAIResponse)

    prompt_template = instance_double(Langchain::Prompt::PromptTemplate)
    allow(prompt_template).to receive(:format).and_return("SomePrompt")

    allow(Langchain::LLM::OpenAI).to receive(:new).and_return(llm)
    allow(Langchain::Prompt::PromptTemplate).to receive(:new).and_return(prompt_template)

    allow(llm_response).to receive(:completion).and_return("SomeResponse")
    allow(llm).to receive(:complete).and_return(llm_response)

    expect(described_class.new.perform(story.id)).to be true
  end
end
