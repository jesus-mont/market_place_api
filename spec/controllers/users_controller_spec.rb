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

  describe 'POST #create' do
    context "when is successfully created" do
      let! (:user) { FactoryBot.attributes_for :user }
      
      before {post :create, params: { user: user  }  }


      it "renders the json representation for the user record just created" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:email]).to eql user[:email]
      end

      it "return successful code" do
        expect(response).to have_http_status(201)
      end  
    end
    
    context "when is not created" do
      
      let!(:invalid_user) {FactoryBot.attributes_for :user_invalid}
        
      before { post :create, params: { user: invalid_user } }
    

      it "renders an errors json" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:errors][:email]).to include "can't be blank"
      end

      it "return 422" do
        expect(response).to have_http_status(422)
      end
    end
  end
end
