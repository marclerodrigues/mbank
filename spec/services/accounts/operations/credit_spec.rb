require 'rails_helper'

RSpec.describe Accounts::Operations::Credit, type: :service do
  let(:user) { create(:user) }
  let(:account) { create(:account, user: user) }
  let(:amount) { 500 }

  subject { described_class.new(account: account, amount: amount) }

  describe '#perform!' do
    it 'increments account balance' do
      expect {
        subject.perform!
        account.reload
      }.to change(account, :balance).by(amount)
    end
  end

  describe '#amount' do
    it 'returns the correct amount' do
      expect(subject.amount).to eq(amount)
    end
  end
end
