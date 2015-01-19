require 'rails_helper'

RSpec.describe ReschedulingsCreatable, type: :controller do
  controller(ApplicationController) do
    include ReschedulingsCreatable
  end

  describe 'POST create' do
    it 'saved the new rescheduling'
  end
end
