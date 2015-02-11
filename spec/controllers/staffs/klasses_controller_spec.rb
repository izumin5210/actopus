require 'rails_helper'

RSpec.describe Staffs::KlassesController, type: :controller do
  sign_in_as_staff

  it_behaves_like 'klasses displayable'
end
