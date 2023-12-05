require "rails_helper"

RSpec.describe StoryCreateJob, type: :job do
  include ActiveJob::TestHelper

  let(:story) { FactoryBot.create(:story) }

  it "performs the job" do
  end

  it "should call the StoryCreateJob with the correct args" do
  end

  it "should not call the StoryCreateJob with incorrect args" do
  end

  it "uses the default LLM if no llm_name is provided" do
    allow(Story).to receive(:find).and_return(story)

    llm = double("Langchain::LLM::OpenAI")
    llm_response = double("Langchain::LLM::OpenAI")

    allow(llm_response).to receive(:completion).and_return("Something")
    allow(llm).to receive(:complete).and_return(llm_response)

    prompt_template = double("PromptTemplate")
    allow(prompt_template).to receive(:format)

    allow(Langchain::LLM::OpenAI).to receive(:new).and_return(llm)
    allow(Langchain::Prompt::PromptTemplate).to receive(:new).and_return(prompt_template)

    StoryCreateJob.new.perform(1) # No llm_name provided

    # Verify that the default LLM is used
    expect(Langchain::LLM::OpenAI).to have_received(:new)
  end
end
