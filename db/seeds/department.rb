Department.transaction do
  puts 'Create departments...'
  Settings.department.each do |dept_params|
    Department.find_or_create_by!(dept_params.to_h)
  end
end
