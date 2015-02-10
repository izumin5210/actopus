require 'active_support/concern'

module RequestHelper
  extend ActiveSupport::Concern

  included do
    let(:headers) do
      { 'Accept' => 'application/json' }
    end
  end
end
