require 'paperclip'
require 'paperclip/railtie'
require 'filemagic'
require 'docsplit'
require 'docsplit-paperclip-processor'

require 'rspec'
require 'rspec/autorun'

# Prepare activerecord
require "active_record"

# Connect to sqlite
ActiveRecord::Base.establish_connection(
  "adapter" => "sqlite3",
  "database" => ":memory:"
)

ActiveRecord::Base.logger = Logger.new(nil)
load(File.join(File.dirname(__FILE__), 'schema.rb'))

Paperclip::Railtie.insert

class Document < ActiveRecord::Base
	has_attached_file :original
end