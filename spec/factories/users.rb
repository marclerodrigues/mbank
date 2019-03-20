FactoryBot.define do
  factory :user do
    first_name { FFaker::NameBR.first_name }
    last_name { FFaker::NameBR.last_name }
    email { FFaker::Internet.email }
  end
end
