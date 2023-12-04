require "test_helper"

class StoryTest < ActiveSupport::TestCase
  def setup
    @mythology = mythologies(:one)
    @story = stories(:one)
  end

  test "should be valid" do
    assert @story.valid?
  end

  test "creativity_temp should return correct value" do
    assert_equal 0.5, @story.creativity_temp
  end
end
