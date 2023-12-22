require "rails_helper"

RSpec.describe "StoryGods" do
  # let!(:story) { create :story }
  # let!(:story_god) { create :story_god }

  it "shows a storygod" do
    get stories_path # story_story_gods_path(story, story_god)
    expect(response).to be_successful
  end
end
