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

    allow(llm_response).to receive(:completion).and_return("Something")
    allow(llm).to receive(:complete).and_return(llm_response)

    prompt_template = instance_double(Langchain::Prompt::PromptTemplate)
    allow(prompt_template).to receive(:format)

    allow(Langchain::LLM::OpenAI).to receive(:new).and_return(llm)
    allow(Langchain::Prompt::PromptTemplate).to receive(:new).and_return(prompt_template)

    expect(described_class.new.perform(story.id)).to be true
  end

  it "uses the default LLM if no llm_name is provided" do
    allow(Story).to receive(:find).and_return(story)
    llm = instance_double(Langchain::LLM::OpenAI)
    llm_response = instance_double(Langchain::LLM::OpenAIResponse)

    allow(llm_response).to receive(:completion).and_return("Something")
    allow(llm).to receive(:complete).and_return(llm_response)

    prompt_template = instance_double(Langchain::Prompt::PromptTemplate)
    allow(prompt_template).to receive(:format)

    allow(Langchain::LLM::OpenAI).to receive(:new).and_return(llm)
    allow(Langchain::Prompt::PromptTemplate).to receive(:new).and_return(prompt_template)

    described_class.new.perform(1)

    # Verify that the default LLM is used
    expect(Langchain::LLM::OpenAI).to have_received(:new)
  end
end
