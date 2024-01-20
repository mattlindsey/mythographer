require "rails_helper"

RSpec.describe "StorySystemTests" do
  it "gives error message on empty title and url" do
    visit new_story_path
    click_link_or_button "Generate Story"

    expect(page).to have_content("Title can't be blank")
    # expect(Story.count).to eq(1) # only seeded story
  end

  it "creates new story" do
    visit stories_path
    assert_selector "h1", text: "Story List"

    click_link_or_button "New Story"
    assert_selector "h1", text: "New Story"

    fill_in "Title", with: "Story about Zeus"
    select "Greek", from: "story_mythology_id"
    select "openai", from: "story_llm_name"

    click_link_or_button "add_god"
    # select "Zeus", from: "story_storygods_attributes_0_god_id"
    click_link_or_button "Generate Story"

    assert_selector "h1", text: "Story about Zeus"
  end
end
