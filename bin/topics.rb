#!/usr/bin/env ruby

lib_dir = File.expand_path('../../lib', __FILE__)
$LOAD_PATH << lib_dir << '.'

require 'topics'

FilePath = '/projects/yahoo/data/00001_05000'

tf = Topics::Finder.new( FilePath )
tf.parse_files
tf.topics.sort.each do |topic|
  puts topic
end