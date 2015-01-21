class Staffs::Reschedulings::LecturersController < Staffs::LecturersController
  include ReschedulingsCreatable

  def index
    @lecturers = Lecturer.all.group_by(&:department_id)
    @departments = Department.all
  end
end
