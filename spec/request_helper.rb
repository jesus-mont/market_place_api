def json_response
  @json_response ||= JSON.parse(response.body, symbolize_names: true)
end

def create_user
  let!(:user) { FactoryBot.create(:user) }
end  