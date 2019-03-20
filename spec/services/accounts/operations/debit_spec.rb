require 'rails_helper'

RSpec.describe Accounts::Operations::Debit, type: :service do
  let(:user) { create(:user) }
  let(:account) { create(:account, user: user) }
  let(:amount) { 500 }

  subject { described_class.new(account: account, amount: amount) }

  describe '#perform!' do
    it 'decrements account balance' do
      expected_decrement = -1 * amount

      expect {
        subject.perform!
        account.reload
      }.to change(account, :balance).by(expected_decrement)
    end
  end

  describe '#amount' do
    it 'returns the correct amount' do
      expect(subject.amount).to eq(amount)
    end
  end
end
