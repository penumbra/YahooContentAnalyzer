require 'rubygems'
require 'rspec'

$LOAD_PATH << File.expand_path('../../lib', __FILE__) << '.'

require 'yahoo'

BasePath = '/projects/yahoo'
OutPath = File::Join( BasePath, 'out' )
DataPath = File::Join( BasePath, 'data' )

SampleHtml = File::Join( OutPath, 'message-01296.html' )
Yahoo_Yml = File::Join( BasePath, 'yahoo_secret.yml' )
