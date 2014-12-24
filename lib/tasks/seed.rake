namespace :db do
  namespace :seed do
    Dir.glob(File.join(Rails.root, 'db', 'seeds', '*.rb')).each do |file|
      desc "Load the seed data from db/seeds/#{File.basename(file)}."
      task(File.basename(file).gsub(/\..+$/, '') => :environment) { load(file) }
    end
  end
end
