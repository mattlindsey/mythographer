require "rails_helper"

RSpec.describe StoryGod do
  let(:story_god) { create(:story_god) }

  before do
    # Mock the vectorsearch functionality to avoid API calls
    allow_any_instance_of(Story).to receive(:upsert_to_vectorsearch)
  end

  it "does not save a storygod with empty role" do
    story_god.role = nil
    expect(story_god.save).to be false
  end
end
