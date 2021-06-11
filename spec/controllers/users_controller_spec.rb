require 'spec_helper'
require 'rails_helper'
require 'request_helper'
describe UsersController do
  before(:each) { request.headers['Accept'] = "application/vnd.marketplace" }

  describe 'GET #show' do
    create_user
    let(:user_id) { user.id }

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
        user_response = json_response
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
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "can't be blank"
      end

      it "return 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PUT/PATCH #update" do
    create_user
    context "when is successfully updated" do
     
      before { patch :update, params:{ id: user.id,
                        user:{ email: "newmail@example.com" } } }

      it "renders the json representation for the updated user" do
        user_response = json_response
        expect(user_response[:email]).to eql "newmail@example.com"
      end

      it "return successful code" do
        expect(response).to have_http_status(200)
      end 
    end

    context 'when the user does not exists' do
      let(:user_id) { 100 }
      before { patch :update, params:{ id: user_id,
                        user:{ email: "newmail@example.com" } } }
      it 'returns status not_found' do
        expect(response).to have_http_status(404)
      end
    end

    context "when is bad request" do
      create_user

      before { patch :update, params:{ id: user.id,
                         user: { email: "bademail.com" } } }


      it "renders an errors json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "is invalid"
      end

      it "return 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE #destroy" do
    create_user
    context 'when destroy sucessful' do
      before { delete :destroy, params: { id: user.id } }
      it "return 204" do
        expect(response).to have_http_status(204)
      end
    end 

    context 'when the user does not exists' do
      let(:user_id) { 100 }
      before { delete :destroy, params: { id: user_id } }
      it 'returns status not_found' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
