require 'rubygems'
require 'rspec'

$LOAD_PATH << File.expand_path('../../lib', __FILE__) << '.'

require 'yahoo'

SampleHtml = '/projects/yahoo/out/message-01296.html'
SampleId = 1296
Yahoo_Yml = '/projects/yahoo/yahoo_secret.yml'