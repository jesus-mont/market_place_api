require 'spec_helper'
require 'rails_helper'

describe UsersController do
  before(:each) { request.headers['Accept'] = "application/vnd.marketplace" }

  describe 'GET #show' do
    let!(:user) { FactoryBot.create(:user) }
    let(:user_id) { user.id }

    # before { get :show, params: { id: user.id } }

    context 'when the response is successful' do
      before { get :show, params: { id: user_id } }
      it 'returns the information about a reporter on a hash' do
        expect(JSON.parse(response.body)['email']).to eq(user.email)
      end

      it 'returns successful code' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the user does not exists' do
      let(:user_id) { 100 }
      before { get :show, params: { id: user_id } }
      it 'returns status not_found' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
