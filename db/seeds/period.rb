Period.transaction do
  puts 'Create periods...'
  Settings.period.each do |period_params|
    Period.find_or_create_by!(period_params.to_h)
  end
end
