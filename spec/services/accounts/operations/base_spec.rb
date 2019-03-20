require 'rails_helper'

RSpec.describe Accounts::Operations::Base, type: :service do
  let(:user) { create(:user) }
  let(:account) { create(:account, user: user) }

  describe '.perform!' do
    subject { described_class.perform!(account: account) }

    it 'raises an exception' do
      expect { subject }.to raise_error(::NotImplementedError)
    end
  end

  describe '#account' do
    subject { described_class.new(account: account) }

    it 'returns the correct account' do
      expect(subject.account).to eq(account)
    end
  end
end
