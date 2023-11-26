require "application_system_test_case"

class StoriesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit stories_url
  #
  #   assert_selector "h1", text: "Stories"
  # end
  test "Creating a new story" do
    visit stories_path
    assert_selector "h1", text: "Story List"

    click_link "New Story"
    assert_selector "h1", text: "New Story"

    fill_in "Title", with: "Story about Zeus"
    # TODO: fix this test
    # select "1", from: "story_mythology_id"
    # click_link "Create Story"

    # assert_selector "h1", text: "Story about Zeus"
    # assert_text "a quote"
  end
end
