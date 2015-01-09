Department.transaction do
  Settings.master.departments.each do |dept_params|
    Department.find_or_create_by!(dept_params.to_h)
  end
end
