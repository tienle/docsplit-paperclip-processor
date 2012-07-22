require 'paperclip'
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