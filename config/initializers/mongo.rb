 require 'mongo'
 @@mongodb = Mongo::Client.new([ 'localhost' ], :database => 'mongoblog_development')