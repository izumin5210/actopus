FactoryGirl.define do
  sequence(:name) { FFaker::NameJA.last_first }
  sequence(:email) { FFaker::Internet.email }
end
