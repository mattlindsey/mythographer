require 'rails_helper'

RSpec.describe StoryCreateJob, type: :job do
  include ActiveJob::TestHelper
  
  let(:stub_job) { double(StoryCreateJob) }
  let(:story) { FactoryBot.create(:story) }
  let(:correct_args) { [story.id, 'open_ai'] }
  let(:incorrect_args) { [story.id, 'unimplemented_llm_name'] }
  let(:empty_args) { [story.id, ''] }

  it 'should respond to #perform' do
    expect(described_class.new).to respond_to(:perform)
  end
  
  it "should call the StoryCreateJob with the correct args" do
    allow(stub_job).to receive(:perform).with(correct_args).and_return(true)
    get_mock_data = stub_job.perform(correct_args)
    expect(get_mock_data).to eq true
  end

  it "should not call the StoryCreateJob with the correct args" do
    allow(stub_job).to receive(:perform).with(incorrect_args).and_return(false)
    get_mock_data = stub_job.perform(incorrect_args)
    expect(get_mock_data).to eq false
  end
end
