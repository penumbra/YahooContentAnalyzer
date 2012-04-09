module Yahoo
  class Finder
    def self.find( fn, xpath )
      f = File.open( fn )
      html = Nokogiri::HTML( f )

      node = html.xpath(xpath)

      # result is returned to caller as text
      node.text
    rescue Exception => ex
      puts "Error with file #{fn} - #{ex}"
      nil  # nil result returned
    ensure
      f.close
    end
  end
end