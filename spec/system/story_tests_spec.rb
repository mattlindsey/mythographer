require "rails_helper"

RSpec.describe "StorySystemTests" do
  it "gives error message on empty title and url" do
    pending "add some examples to (or delete) #{__FILE__}"

    visit new_story_path
    click_link_or_button "Generate Story"

    expect(page).to have_content("Title can't be blank")
    # expect(Story.count).to eq(0)
  end

  it "creates new story" do
    pending "add some examples to (or delete) #{__FILE__}"

    visit stories_path
    assert_selector "h1", text: "Story List"

    click_link_or_button "New Story"
    assert_selector "h1", text: "New Story"

    fill_in "Title", with: "Story about Zeus"
    select "Greek", from: "story_mythology_id"
    fill_in "god_id", with: "Zeus"
    click_link_or_button "Generate Story"

    assert_selector "h1", text: "Story about Zeus"
  end
end
