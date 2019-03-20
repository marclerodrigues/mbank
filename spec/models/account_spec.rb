require 'rails_helper'

RSpec.describe Account, type: :model do
  context 'relations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:transfers).dependent(:nullify) }
    it { is_expected.to have_many(:received_transfers).dependent(:nullify).class_name('Transfer') }
  end

  context '.find_by_access_token_and_id' do
    let(:user) { create(:user, access_token: 'token') }
    let(:account) { create(:account, user: user) }

    context 'with the correct token' do
      subject { described_class.find_by_access_token_and_id('token', account.id) }

      it 'returns the correct account' do
        expect(subject).to eq(account)
      end
    end

    context 'with the incorrect token' do
      subject { described_class.find_by_access_token_and_id('incorrect-token', account.id) }

      it 'does not return an account' do
        expect(subject).to be_nil
      end
    end
  end
end
