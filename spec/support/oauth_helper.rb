require 'active_support/concern'

module OAuthHelper
  extend ActiveSupport::Concern

  included do
    let(:headers) do
      { 'Accept' => 'application/json',
        'Authorization' => authorization_header_value
      }
    end

    let(:authorization_header_value) { "Bearer #{access_token.token}" }

    let(:application) { create(:application) }
    let(:access_token) do
      create(:access_token,
             application: application,
             resource_owner_id: resource_owner,
             scopes: scopes
            )
    end

    let(:scopes) { 'public' }
    let(:resource_owner) { nil }
  end
end
