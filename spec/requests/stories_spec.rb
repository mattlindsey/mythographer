require "rails_helper"

RSpec.describe "Stories" do
  # let!(:story) { create(:story) }

  it "shows all stories" do
    get stories_path
    # expect(response).to be_successful
    expect(response.body).to include("<h1>Story List</h1>")
  end
end
