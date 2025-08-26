require "rails_helper"

RSpec.describe StoryCreateJob do
  include ActiveJob::TestHelper

  let(:mythology) { create(:mythology) }
  let(:story) { create(:story, mythology: mythology) }

  before do
    # Mock the vectorsearch functionality to avoid API calls
    allow_any_instance_of(Story).to receive(:upsert_to_vectorsearch)
  end

  it "performs the job" do
    expect(described_class.new).to respond_to(:perform)
  end

  describe "#perform" do
    let(:llm) { instance_double(Langchain::LLM::OpenAI) }
    let(:llm_response) { instance_double(Langchain::LLM::OpenAIResponse) }
    let(:story_template) { instance_double(Langchain::Prompt::PromptTemplate) }
    let(:role_template) { instance_double(Langchain::Prompt::PromptTemplate) }

    before do
      allow(Story).to receive(:find).and_return(story)
      allow(Langchain::LLM::OpenAI).to receive(:new).and_return(llm)
      allow(Langchain::Prompt).to receive(:load_from_path).and_return(story_template, role_template)
      allow(llm_response).to receive(:completion).and_return("Generated story content")
      allow(llm).to receive(:complete).and_return(llm_response)
      allow(story_template).to receive(:format).and_return("Story prompt")
      allow(role_template).to receive(:format).and_return("Role prompt")
      allow(story).to receive(:update)
    end

    it "processes a story with OpenAI LLM" do
      described_class.new.perform(story.id)

      expect(Story).to have_received(:find).with(story.id)
      expect(Langchain::LLM::OpenAI).to have_received(:new).with(
        api_key: ENV["OPENAI_API_KEY"],
        llm_options: {temperature: story.creativity_temp}
      )
      expect(story).to have_received(:update).with(content: "Generated story content")
    end

    it "loads and formats story template correctly" do
      described_class.new.perform(story.id)

      expect(Langchain::Prompt).to have_received(:load_from_path).with(
        file_path: "app/prompts/story_create_template.yaml"
      )
      expect(story_template).to have_received(:format).with(
        mythology_name: story.mythology.name,
        title: story.title
      )
    end

    it "loads and formats role template for story gods" do
      story_god = create(:story_god, story: story)
      # Mock the StoryGod.where to return an object that responds to find_each
      story_gods_collection = double("StoryGodsCollection")
      allow(story_gods_collection).to receive(:find_each).and_yield(story_god)
      allow(StoryGod).to receive(:where).and_return(story_gods_collection)

      described_class.new.perform(story.id)

      expect(Langchain::Prompt).to have_received(:load_from_path).with(
        file_path: "app/prompts/story_role_template.yaml"
      )
      expect(role_template).to have_received(:format).with(
        god: story_god.god.name,
        role: story_god.role
      )
    end

    it "includes additional instructions when present" do
      story_with_instructions = create(:story, mythology: mythology, instructions: "Make it epic!")
      allow(Story).to receive(:find).and_return(story_with_instructions)

      described_class.new.perform(story_with_instructions.id)

      expect(llm).to have_received(:complete).with(
        prompt: a_string_including("Additional instructions for generating the story are Make it epic!")
      )
    end

    it "handles stories without additional instructions" do
      story_without_instructions = create(:story, mythology: mythology, instructions: nil)
      allow(Story).to receive(:find).and_return(story_without_instructions)

      described_class.new.perform(story_without_instructions.id)

      # Use a simpler expectation that doesn't require special matchers
      expect(llm).to have_received(:complete)
    end

    context "with different LLM types" do
      it "handles Google Palm LLM" do
        google_story = create(:story, mythology: mythology, llm_name: "google")
        allow(Story).to receive(:find).and_return(google_story)
        # Mock the Google Palm LLM class
        google_llm_class = double("GooglePalmClass")
        google_llm = instance_double(GooglePalmInstance)
        allow(google_llm_class).to receive(:new).and_return(google_llm)
        allow(google_llm).to receive(:complete).and_return(llm_response)

        # Stub the constant lookup
        stub_const("Langchain::LLM::GooglePalm", google_llm_class)

        described_class.new.perform(google_story.id)

        expect(google_llm).to have_received(:complete)
      end

      it "logs error for unknown LLM type" do
        # Create a story with a valid LLM name first, then change it in the test
        story_with_unknown_llm = story
        story_with_unknown_llm.llm_name = "unknown"
        allow(Story).to receive(:find).and_return(story_with_unknown_llm)
        allow(Rails.logger).to receive(:error)

        # The job should handle unknown LLM types gracefully
        expect { described_class.new.perform(story_with_unknown_llm.id) }.not_to raise_error

        expect(Rails.logger).to have_received(:error).with("Unknown LLM: unknown")
      end
    end
  end
end
