#!/usr/bin/env ruby

lib_dir = File.expand_path('../../lib', __FILE__)
$LOAD_PATH << lib_dir << '.'

require 'yahoo'

ConfigFile = '/projects/yahoo/yahoo_secret.yml'
TopicsFile = '/projects/yahoo/data/topics.txt'

def save_topic_set( topic_runner )
  f = File.open( TopicsFile, 'w' )

  topic_runner.topics.sort.each {|t| f.puts t }

  f.close
end

tr = Yahoo::Topics::Runner.new( ConfigFile )

# process all message-####.html files anywhere within the data_path folder
tr.process_messages

save_topic_set( tr )
