require 'rails_helper'

RSpec.describe BalanceController, type: :controller do
  context "GET#show" do
    let(:user) { create(:user, access_token: 'token') }
    let(:account) { create(:account, user: user, balance: 1000) }

    context 'when account exists' do
      before do
        get :show, params: { id: account.id }
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'returns the correct payload' do
        payload = JSON.parse(response.body).symbolize_keys

        expect(payload).to include(success: true, balance: 1000)
      end
    end
  end

  context 'when does not account exist' do
    before do
      get :show, params: { id: '123' }
    end

    it 'doest return a successful response' do
      expect(response).not_to be_successful
    end

    it 'returns the correct response' do
      expect(response).to be_not_found
    end

    it 'returns the correct payload' do
      payload = JSON.parse(response.body).symbolize_keys

      expect(payload).to include(success: false, error: 'Account not found')
    end
  end
end
