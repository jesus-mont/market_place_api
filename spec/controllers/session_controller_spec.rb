require 'spec_helper'
require 'rails_helper'
require 'request_helper'

describe SessionsController do

    describe "POST #create" do

        user= FactoryBot.create :user

        context "when the credentials are correct" do
           

            credentials = { email: user.email, password: "12345678" }
            before { post :create, params:{ session: credentials } }

            it "returns the user record corresponding to the given credentials" do
                user.reload
                expect(json_response[:auth_token]).to eql user.auth_token
            end

            it "return successful code" do
                expect(response).to have_http_status(200)
              end
        end

        context "when the credentials are incorrect" do
            credentials =  { email: user.email, password: "invalidpassword" }
            before { post :create, params:{ session: credentials } }
    
            it "returns a json with an error" do
                expect(json_response[:errors]).to eql "Invalid email or password"
            end

            it "return 422" do
                expect(response).to have_http_status(422)
            end
        end
    end

    describe "DELETE #destroy" do
        user= FactoryBot.create :user
        # https://stackoverflow.com/questions/34787043/undefined-method-to-key-for-store-falsehash-when-using-sign-in-helper
        # before{ sign_in @user, store: false }
        before{ sign_in user }
        before { delete :destroy, params:{id: user.auth_token} }

        it "return 204" do
            expect(response).to have_http_status(204)
        end

  end
end