require 'rails_helper'

RSpec.describe Mythology, type: :model do
  subject { build(:mythology) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a description' do
      subject.description = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a duplicate name' do
      create(:mythology, name: subject.name)
      expect(subject).to_not be_valid
    end

    it 'is not valid with a name longer than 255 characters' do
      subject.name = 'a' * 256
      expect(subject).to_not be_valid
    end

    it 'is not valid with a description longer than 1000 characters' do
      subject.description = 'a' * 1001
      expect(subject).to_not be_valid
    end
  end
end
