class LecturersController < ApplicationController
  def index
    @lecturers = Lecturer.all.group_by(&:department_id)
    @department = Department.all
  end
end
