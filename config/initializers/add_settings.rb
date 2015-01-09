%w(departments courses klasses periods).each do |master|
  Settings.add_source!("#{Rails.root}/db/master/#{master}.yml")
end

Settings.reload!
