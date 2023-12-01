require 'rails_helper'

RSpec.describe StoryCreateJob, type: :job do
  let(:story) { FactoryBot.create(:story, :id => 1) }
  let(:correct_args) { [story.id, 'open_ai'] }
  let(:incorrect_args) { [story.id, 'unimplemented_llm_name'] }
  let(:empty_args) { [story.id, ''] }
  let(:llm) { Langchain::LLM::OpenAI.new(api_key: "123") }

  it 'should respond to #perform' do
    expect(described_class.new).to respond_to(:perform)
  end
  
  it "should call the StoryCreateJob with the correct args" do
    allow(llm).to receive(:complete).and_return('some string')
    allow(described_class.new).to receive(:perform).with(correct_args[0], correct_args[1]).and_return(true)
    expect(described_class.new.perform(correct_args[0], correct_args[1])).to eq ''
  end

  it "should not call the StoryCreateJob with the correct args" do
    allow(described_class.new).to receive(:perform).with(incorrect_args[0], incorrect_args[1]).and_return(false)
    expect(described_class.new.perform(incorrect_args[0], incorrect_args[1])).to eq ''
  end
end
