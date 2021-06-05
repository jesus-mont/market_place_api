FactoryBot.define do
    factory :user, class: 'User' do
      name { "Aragon"  }
      phone { "3468495791" }  
      email { FFaker::Internet.email }
      password { "12345678" }
      password_confirmation { "12345678" }
    end

    factory :user_invalid, class: 'User' do
      name { "Aragon"  }
      phone { "3468495791" }  
      password { "12345678" }
      password_confirmation { "12345678" }
    end
  end


