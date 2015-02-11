class LecturersController < ApplicationController
  layout 'unsignedin_users'
  include LecturersDisplayable
end
