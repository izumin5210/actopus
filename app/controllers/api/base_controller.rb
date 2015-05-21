class Api::BaseController < ApplicationController
  include Garage::ControllerHelper

  def current_resource_owner
    @current_resource_owner ||= Staff.find(resource_owner_id) if resource_owner_id
  end
end
