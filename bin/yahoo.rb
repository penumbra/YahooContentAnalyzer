#!/usr/bin/env ruby

lib_dir = File.expand_path('../../lib', __FILE__)
$LOAD_PATH << lib_dir << '.'

require 'yahoo'

# uses lib/yahoo.rb to read SynchronicityPhenomena group content
yahoo = Yahoo.new( 'YOUR_YAHOO_ID@yahoo.com', 'PASSWORD_HERE')

html = yahoo.select_group( 'SynchronicityPhenomena' )

# Browse::Helper::save( 'data/synchronicity_phenomena.html', html ) unless html == nil

(10000..20000).each do |id|
  html = yahoo.get_message(id)

  sleep( 10 )
 
  if html != nil
    filename = format("data/message-%05d.html", id)
    puts "writing #{filename}..."
    Browse::Helper::save( filename, html)
  end
end
