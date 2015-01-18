class Api::BaseController < ApplicationController
  include Garage::ControllerHelper

  def current_resource_owner
  end
end
