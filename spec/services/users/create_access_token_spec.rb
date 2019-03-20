require 'rails_helper'

RSpec.describe Users::CreateAccessToken, type: :service do
  context ".perform" do
    let(:user_attributes) { attributes_for(:user) }
    let(:user) { create(:user, user_attributes) }
    let(:expected_token) { JWT.encode(user_attributes, nil, 'none') }

    subject { described_class.perform(user: user) }

    it 'sets the user access_token' do
      expect { subject }.to change(user, :access_token)
    end

    it 'create the correct access_token' do
      subject

      user.reload

      expect(user.access_token).to eq(expected_token)
    end
  end
end
