$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rspec'

require 'sqlite3'
require 'rails'
require 'active_record'

require 'connection_ninja/orms/active_record'

require File.join(File.expand_path(File.dirname(__FILE__)), 'fixtures/models')

FileUtils.mkdir_p "#{Dir.pwd}/tmp"
ActiveRecord::Base.logger         = Logger.new(StringIO.new)
ActiveRecord::Base.configurations = YAML.load_file(File.join("spec", "fixtures", "database.yml"))

