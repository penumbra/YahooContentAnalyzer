require 'yaml'
require 'net/http'
require 'uri'

module Yahoo
  module Content
    module Analyze
      class Alchemy < Yahoo::Shared::Config
        attr_reader :doc

        def initialize
          super( $ConfigFile )

          add_properties!( AlchemyTag )

          @http = Net::HTTP.new( @host, @port )
        end

        # return the Alchemy API response as Nokogiri XML Doc
        def analyze( html )
          puts "analyze => #{html.msg}"
        end
      end  # Alchemy Class
    end  # Analyze
  end # Content
end # Yahoo