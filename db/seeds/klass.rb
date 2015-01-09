Klass.transaction do
  Settings.master.klasses.each do |klass_params|
    department = Department.find_by(abbreviation_name: klass_params.department)
    course = Course.find_by(abbreviation_name: klass_params.course)
    Klass.find_or_create_by!(
      name: klass_params.name, grade: klass_params.grade,
      category: klass_params.category || 0,
      department: department, course: course
    )
  end
end
