class Staffs::LecturersController < Staffs::BaseController
  include LecturersDisplayable

  def index
    @lecturers = Lecturer.eager_load(:department).all
  end
end
