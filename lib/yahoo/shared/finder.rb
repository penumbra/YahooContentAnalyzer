module Yahoo
  module Shared
    module Finder
      def find( fn, xpath )
        f = File.open( fn )
        html = Nokogiri::HTML( f )

        html.xpath( xpath )
      rescue Exception => ex
        puts "Error with file #{fn} - #{ex}"
        nil  # nil result returned
      ensure
        f.close
      end
    end # Finder
  end
end