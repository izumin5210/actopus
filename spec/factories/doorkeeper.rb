FactoryGirl.define do
  factory :access_token, class: Doorkeeper::AccessToken do
    expires_in 1.hours
    application
  end

  factory :application, class: Doorkeeper::Application do
    sequence(:name) { |n| "Application #{n}" }
    redirect_uri 'https://example.com/callback'
  end
end
