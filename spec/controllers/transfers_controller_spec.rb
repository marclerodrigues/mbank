require 'rails_helper'

RSpec.describe TransfersController, type: :controller do
  context 'POST#create' do
    let(:access_token) { 'access_token' }
    let(:sender) { create(:user, access_token: access_token) }
    let(:receiver) { create(:user) }
    let(:source_account) { create(:account, user: sender, balance: 1000) }
    let(:destination_account) { create(:account, user: receiver, balance: 0) }
    let(:amount) { 500 }

    context 'with valid attributes' do
      let(:transfer_params) {
        {
          transfer: {
            source_account_id: source_account.id,
            destination_account_id: destination_account.id,
            amount: amount,
            access_token: access_token
          }
        }
      }

      before do
        post :create, params: transfer_params
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'returns the correct payload' do
        payload = JSON.parse(response.body).symbolize_keys

        expect(payload).to eq({ success: true })
      end

      it 'debits amount from source account' do
        source_account.reload

        expect(source_account.balance).to eq(500)
      end

      it 'credits the amount to destination account' do
        destination_account.reload

        expect(destination_account.balance).to eq(500)
      end

      it 'creates a new transfer' do
        expect {
          post :create, params: transfer_params
        }.to change(Transfer, :count).by(1)
      end

      it 'creates a new transfer with the correct params' do
        expected_params = {
          source_account_id: source_account.id,
          destination_account_id: destination_account.id,
          amount: amount,
        }
        transfer_params = Transfer.last.attributes.symbolize_keys

        expect(transfer_params).to include(expected_params)
      end
    end

    context 'with invalid attributes' do
      [:source_account_id, :destination_account_id, :amount, :access_token].each do |attribute|
        let(:transfer_params) {
          {
            transfer: {
              source_account_id: source_account.id,
              destination_account_id: destination_account.id,
              amount: amount,
              access_token: access_token
            }
          }.merge(attribute => nil)
        }

        before do
          post :create, params: transfer_params
        end

        it 'does not return a successful response' do
          expect(response).not_to be_successful
        end

        it 'returns the correct payload' do
          payload = JSON.parse(response.body).symbolize_keys

          expect(payload).to include({ success: false })
        end

        it 'returns the errors' do
          payload = JSON.parse(response.body).symbolize_keys
          errors = payload[:errors]

          expect(errors).to be_present
        end

        it 'does not create a new transfer' do
          expect {
            post :create, params: transfer_params
          }.not_to change(Transfer, :count)
        end
      end
    end
  end
end
