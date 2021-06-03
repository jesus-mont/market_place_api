FactoryBot.define do
    factory :user do
      name { "Aragon"  }
      phone { "3468495791" }  
      email { FFaker::Internet.email }
      password { "12345678" }
      password_confirmation { "12345678" }
    end
  end