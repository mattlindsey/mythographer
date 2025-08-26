require "rails_helper"

RSpec.describe Story do
  let(:story) { create(:story) }

  before do
    # Mock the vectorsearch functionality to avoid API calls
    allow_any_instance_of(described_class).to receive(:upsert_to_vectorsearch)
  end

  it "is valid" do
    expect(story).to be_valid
  end

  it "saves a story with valid properties" do
    expect(story.save).to be true
  end

  it "does not save a story with empty title" do
    story.title = nil
    expect(story.save).to be false
  end

  it "displays reason for not saving a story" do
    story.title = nil
    story.save
    expect(story.errors[:title]).to include("can't be blank")
  end

  it "returns the correct creativity_temp" do
    expect(story.creativity_temp).to be(0.5)
  end

  it "calls broadcast_replace_to with correct argument after update" do
    expect(story).to receive(:broadcast_replace_to).with("stories") # rubocop:disable RSpec/MessageSpies
    story.save
  end
end
