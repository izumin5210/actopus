require 'active_support/concern'

module RequestHelper
  extend ActiveSupport::Concern

  included do
    let(:headers) do
      {
        'Accept' => 'application/json',
        'Authorization' => authorization_header_value
      }
    end

    let(:authorization_header_value) { "Bearer #{access_token.token}" }

    let(:access_token) do
      FactoryGirl.create(
        :access_token,
        scopes: scopes,
        application: application
      )
    end

    let(:scopes) { 'public' }
    let(:application) { create(:application) }
  end
end
