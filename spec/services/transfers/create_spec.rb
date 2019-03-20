require 'rails_helper'

RSpec.describe Transfers::Create, type: :service do
  describe '.perform' do
    let(:user) { create(:user, access_token: 'token') }
    let(:source_account) { create(:account, user: user, balance: 500) }
    let(:destination_account) { create(:account, user: user) }
    let(:amount) { 500 }
    let(:params) {
      {
        source_account_id: source_account.id,
        destination_account_id: destination_account.id,
        amount: amount,
        access_token: 'token'
      }
    }

    subject { described_class.perform(params: params) }

    context 'with a valid transfer' do
      it 'creates a new tranfer' do
        expect {
          subject
        }.to change(Transfer, :count).by(1)
      end

      it 'debits from source account' do
        expect {
          subject
          source_account.reload
        }.to change(source_account, :balance).by(-500)
      end

      it 'credits to destination account' do
        expect {
          subject
          destination_account.reload
        }.to change(destination_account, :balance).by(500)
      end
    end

    context 'with an invalid valid transfer' do
      let(:amount ) { 1500 }

      it 'does not create a new tranfer' do
        expect {
          subject
        }.not_to change(Transfer, :count)
      end

      it 'doest not debit from source account' do
        expect {
          subject
          source_account.reload
        }.not_to change(source_account, :balance)
      end

      it 'does not credit to destination account' do
        expect {
          subject
          destination_account.reload
        }.not_to change(destination_account, :balance)
      end
    end
  end
end
