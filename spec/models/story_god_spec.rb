require "rails_helper"

RSpec.describe StoryGod do
  let(:story_god) { create(:story_god) }

  it "does not save a storygod with empty role" do
    story_god.role = nil
    expect(story_god.save).to be false
  end
end
