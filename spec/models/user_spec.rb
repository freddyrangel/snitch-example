require 'rails_helper'

RSpec.describe User do
  describe '.first_name', pending: true do
    it 'should output the user\'s name' do
      expect(true).to eq false
    end

    it 'should not return someone else\'s name' do
      expect(true).to eq false
    end
  end

  describe '.last_name' do
    it 'should output the user\'s last name'
    it 'should create an issue', pending: true do
      expect(true).to eq false
    end
  end

  describe '.some_new_method' do
    it 'is pending'

    context 'when pending' do
      it 'should be reported to Github as an issue'
      it 'should also be reported to GH'
    end
  end
end
