def json_response
  @json_response ||= JSON.parse(response.body, symbolize_names: true)
end

def create_user
  let!(:user) { FactoryBot.create(:user) }
end

def api_authorization_header(token)
  request.headers['Authorization'] =  token
end

def create_product
  let!(:product) { FactoryBot.create(:product) }
end