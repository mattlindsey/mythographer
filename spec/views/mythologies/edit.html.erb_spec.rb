require 'rails_helper'

RSpec.describe "mythologies/edit", type: :view do
  before(:each) do
    @mythology = assign(:mythology, Mythology.create!(
      name: "Greek",
      description: "Greek mythology"
    ))
  end

  it "renders the edit mythology form" do
    render

    assert_select "form[action=?][method=?]", mythology_path(@mythology), "post" do
      assert_select "input[name=?]", "mythology[name]"
      assert_select "textarea[name=?]", "mythology[description]"
    end
  end
end
