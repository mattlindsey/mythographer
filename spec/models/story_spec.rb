require "rails_helper"

RSpec.describe Story do
  let(:story) { create(:story) }

  it "is valid" do
    expect(story).to be_valid
  end

  it "saves a story with valid properties" do
    expect(story.save).to be true
  end

  it "does not save a story with empty title" do
    story.title = nil
    expect(story.save).to be false
    # expect(story.errors[:title]).to include("can't be blank")
  end

  it "returns the correct creativity_temp" do
    expect(story.creativity_temp).to be(0.5)
  end

  it "calls broadcast_replace_to with correct argument after update" do
    # mock_story = instance_spy(described_class)
    # allow(described_class).to receive(:broadcast_replace_to).with("stories").and_return(true)
    # story.save
    # expect(story).to have_received(:broadcast_replace_to)
    # expect(mock_story).to have_received(:broadcast_replace_to).with("stories")
    # OR
    expect(story).to receive(:broadcast_replace_to).with("stories") # rubocop:disable RSpec/MessageSpies
    story.save
  end
end
