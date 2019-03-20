require 'rails_helper'

RSpec.describe Transfers::Validation, type: :service do
  describe '.perform' do
    let(:user) { create(:user) }
    let(:source_account) { create(:account, user: user, balance: 500) }
    let(:destination_account) { create(:account, user: user) }
    let(:amount) { 500 }

    subject { described_class.perform(source_account: source_account, destination_account: destination_account, amount: amount) }

    context 'with valid source destination' do
      it { is_expected.to be true }
    end

    context 'with invalid source destination' do
      let(:source_account) { nil }

      it { is_expected.to be false }
    end

    context 'with invalid amount' do
      let(:amount) { 1000 }

      it { is_expected.to be false }
    end

    context 'with invalid destination account' do
      let(:destination_account) { nil }

      it { is_expected.to be false }
    end
  end
end
