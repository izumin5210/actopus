module PublicApi
  extend ActiveSupport::Concern

  included do
    include Garage::NoAuthentication
    skip_before_action :doorkeeper_authorize!
  end
end
