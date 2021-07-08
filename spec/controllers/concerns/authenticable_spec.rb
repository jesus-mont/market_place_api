require 'spec_helper'
require 'rails_helper'
require 'request_helper'

class Authentication
  include Authenticable
  attr_reader :request, :response
end

describe Authenticable do
  let(:authentication) { Authentication.new }
  subject { authentication }

  describe "#current_user" do
    before do
      @user = FactoryBot.create :user
      request.headers["Authorization"] = @user.auth_token
      allow(authentication).to receive(:request).and_return(request)
    end
    
    it "returns the user from the authorization header" do
      expect(authentication.current_user.auth_token).to eql @user.auth_token
    end
  end

  describe "#authenticate_with_token" do
    before do
      @user = FactoryBot.create :user
      allow(authentication).to receive(:current_user).and_return(nil)
      allow(response).to receive(:status).and_return(401)
      allow(response).to receive(:body).and_return({"errors" => "Not authenticated"}.to_json)
      allow(authentication).to receive(:response).and_return(response)
    end

    it "render a json error message" do
      expect(json_response[:errors]).to eql "Not authenticated"
    end

    it "return 401" do
        expect(response).to have_http_status(401)
    end
  end

  describe "#user_signed_in?" do
    context "when there is a user on 'session'" do
      before do
        @user = FactoryBot.create :user
        allow(authentication).to receive(:current_user).and_return(@user)
      end

      it "should be signed in" do
        should be_user_signed_in
      end
    end

    context "when there is no user on 'session'" do
      before do
        @user = FactoryBot.create :user
        allow(authentication).to receive(:current_user).and_return(nil)
      end

      it "should not be signed in" do
       should_not be_user_signed_in 
      end
    end
  end
end