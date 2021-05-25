require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'A user can be created' do
    let(:name) { 'simple name' }

    it 'user is valid if it has name' do
      user = User.create(name: 'name', username: 'username')
      expect(user).to be_valid
    end

    it 'user is not valid if name is not present' do
      user = User.create
      expect(user).not_to be_nil
    end
  end
end
