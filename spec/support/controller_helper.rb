require 'active_support/concern'

module ControllerHelper
  extend ActiveSupport::Concern

  included do
    def self.sign_in_as_staff
      let(:staff) { create(:staff) }
      before { sign_in staff }
    end
  end
end
