require 'json'
require 'prmd/rake_tasks/combine'
require 'prmd/rake_tasks/verify'

DOC_DIR = Rails.root.join('doc')
SCHEMATA_DIR = DOC_DIR.join('schemata')
FIXTURES_DIR = Rails.root.join('spec/javascripts/fixtures')

META_FILE_PATH = DOC_DIR.join('meta.yml')
SCHEMA_FILE_PATH = DOC_DIR.join('api.json')
DOC_FILE_PATH = DOC_DIR.join('api.md')

def json
  JSON.parse(File.read(SCHEMA_FILE_PATH))
end

def schema
  JsonSchema.parse!(json).tap(&:expand_references!)
end

namespace :json_schema do
  Prmd::RakeTasks::Combine.new do |t|
    puts 'Combine schemata...'
    t.options[:meta] = META_FILE_PATH
    t.paths << SCHEMATA_DIR
    t.output_file = SCHEMA_FILE_PATH
  end

  Prmd::RakeTasks::Verify.new do |t|
    puts 'Verify schema...'
    t.files << SCHEMA_FILE_PATH
  end

  desc 'Generate .json files from schema'
  task :fixtures do
    puts 'Generate fixtures...'
    schema.properties.map do |resource, subschema|
      path = FIXTURES_DIR.join("#{resource}.json")
      res = Rack::JsonSchema::Mock::ResponseGenerator.call(subschema)
      open(path, 'w') { |io| JSON.dump(res, io) }
    end
  end

  desc 'Generate documentation'
  task :doc do
    puts 'Generate documentation...'
    File.write(DOC_FILE_PATH, Jdoc::Generator.call(json))
  end
end

task :json_schema do
  %w(combine verify doc fixtures).each do |task|
    Rake::Task["json_schema:#{task}"].invoke
  end
end
