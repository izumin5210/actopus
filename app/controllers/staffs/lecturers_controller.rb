class Staffs::LecturersController < Staffs::BaseController
  def index
    @lecturers = Lecturer.all
  end
end
