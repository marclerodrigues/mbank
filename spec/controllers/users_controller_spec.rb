require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'POST#create' do
    context 'with valid attributes' do
      let(:user_attributes) { attributes_for(:user) }
      let(:access_token) { JWT.encode(user_attributes, nil, 'none') }

      before do
        post :create, params: { user: user_attributes }
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'returns the correct payload' do
        payload = {
          success: true,
          access_token: access_token
        }
        parsed_payload = JSON.parse(response.body).symbolize_keys

        expect(parsed_payload).to match(payload)
      end

      it 'sets the user access_token' do
        expect(User.last.access_token).to be_present
      end

      it 'creates a new user' do
        expect {
          post :create, params: { user: user_attributes }
        }.to change(User, :count).by(1)
      end
    end
  end

  context 'with invalid attributes' do
    let(:user_attributes) { attributes_for(:user, first_name: nil) }

    before do
      post :create, params: { user: user_attributes }
    end

    it 'does not return a successful response' do
      expect(response).not_to be_successful
    end

    it 'returns the errors' do
      payload = JSON.parse(response.body).symbolize_keys
      errors = payload[:errors]

      expect(errors).to be_present
    end

    it 'does not create a new user' do
      expect {
        post :create, params: { user: user_attributes }
      }.not_to change(User, :count)
    end
  end
end
