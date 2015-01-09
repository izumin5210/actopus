Period.transaction do
  Settings.master.periods.each do |period_params|
    Period.find_or_create_by!(period_params.to_h)
  end
end
