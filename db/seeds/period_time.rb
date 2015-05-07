PeriodTime.transaction do
  Settings.master.period_times.each do |period_time_params|
    PeriodTime.find_or_create_by!(period_time_params.to_h)
  end
end
