require 'spec_helper'
require "rails_helper"
require "pry"
describe UsersController do

  before(:each) { request.headers['Accept'] = "application/vnd.marketplace" }

  describe "GET #show" do
    before(:each) do
      @user = FactoryBot.create :user
      subject { get :show, params: {id: @user.id} }
    end

    # it "returns the information about a reporter on a hash" do
    #   binding.pry  
    #   user_response = JSON.parse(response.body, symbolize_names: true)
    #   expect(user_response[:email]).to eql @user.email
    # end

    it { expect(response).to have_http_status(200) }
 end

end