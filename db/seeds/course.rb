Course.transaction do
  Settings.course.each do |course_params|
    Course.find_or_create_by!(course_params.to_h)
  end
end
