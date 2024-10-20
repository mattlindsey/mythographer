require 'rails_helper'

RSpec.describe "mythologies/new.html.erb", type: :view do
  before(:each) do
    assign(:mythology, Mythology.new)
  end

  it "renders new mythology form" do
    render

    assert_select "form[action=?][method=?]", mythologies_path, "post" do
      assert_select "input[name=?]", "mythology[name]"
      assert_select "textarea[name=?]", "mythology[description]"
    end
  end
end
