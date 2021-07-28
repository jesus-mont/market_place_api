require 'spec_helper'
require 'rails_helper'
require 'request_helper'
describe ProductsController do
    describe "GET #show" do

        create_product
        let(:product_id) {product.id}
        before { get :show, params: { id: product_id } }
      it "returns the information about a reporter on a hash" do
        product_response = json_response
        expect(JSON.parse(response.body)['title']).to eq(product.title)
      end
  
      it 'returns successful code' do
        expect(response).to have_http_status(200)
      end
    end
    
    describe "GET #index" do
      
    before(:each) do
      4.times { FactoryBot.create :product }
      get :index
    end
      

      it "returns 4 records from the database" do
        response = json_response
        # binding.pry
        expect(response.product.size == 4)
      end

      it 'returns successful code' do
        expect(response).to have_http_status(200)
      end
    end

    describe "POST #create" do
      context "when is successfully created" do
        before(:each) do
          user = FactoryBot.create :user
          @product_attributes = FactoryBot.attributes_for :product
          api_authorization_header user.auth_token
          post :create, params:{ user_id: user.id, product: @product_attributes }
        end

        it "renders the json representation for the product record just created" do
          product_response = json_response
          expect(product_response[:title]).to eql @product_attributes[:title]
        end

        it "return successful code" do
          expect(response).to have_http_status(201)
        end 
      end

      context "when is not created" do
        before(:each) do
          user = FactoryBot.create :user
          @invalid_product_attributes = { title: "Smart TV", price: "Twelve dollars" }
          api_authorization_header user.auth_token
          post :create, params: { user_id: user.id, product: @invalid_product_attributes }
        end

        it "renders an errors json" do
          product_response = json_response
          expect(product_response).to have_key(:errors)
        end

        it "renders the json errors on whye the user could not be created" do
          product_response = json_response
          expect(product_response[:errors][:price]).to include "is not a number"
        end

        it "return 422" do
          expect(response).to have_http_status(422)
        end
      end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryBot.create :user
      @product = FactoryBot.create :product, user: @user
      api_authorization_header @user.auth_token
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, params: { user_id: @user.id, id: @product.id,
              product: { title: "An expensive TV" } }
      end

      it "renders the json representation for the updated user" do
        product_response = json_response
        expect(product_response[:title]).to eql "An expensive TV"
      end

      it "return successful code" do
        expect(response).to have_http_status(200)
      end 
    end

    context "when is not updated" do
      before(:each) do
        patch :update, params: { user_id: @user.id, id: @product.id,
              product: { price: "two hundred" } }
      end

      it "renders an errors json" do
        product_response = json_response
        expect(product_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        product_response = json_response
        expect(product_response[:errors][:price]).to include "is not a number"
      end

      it "return 422" do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      user = FactoryBot.create :user
      product = FactoryBot.create :product, user: user
      api_authorization_header user.auth_token
      delete :destroy, params: { user_id: user.id, id: product.id }
    end

    it "return successful code" do
      expect(response).to have_http_status(204)
    end
  end
end