module Yahoo
  module Content
    module Parse
      class Links
        MessageLinks = "//noscript/a"

        def initialize
          puts "Links constructor"
        end

        # <a href="/group/SynchronicityPhenomena/message/1336?threaded=1&var=1&l=1&p=15">
        #    <span>Re: Lucid Dreams synch</span>
        # </a>
        def find( fn )
          f = File.open( fn )
          html = Nokogiri::HTML( f )

          get_ids( html )
        rescue Exception => ex
            puts "Exception #{ex}"
        ensure
          f.close
        end

        # use regex to compile an array of related message id's
        def get_ids( html )
          ids = []
          node_list = html.xpath( MessageLinks )

          if node_list != nil
            node_list.each do |node|
              href = "node => #{node['href']}"

              if href =~ /p=[0-9]*$/
                href =~ /(message\/\d*)/
                match = $~

                # get the numeric part only
                id = match.string[match.begin(0)+8 .. match.end(0)-1]

                # convert to an integer before adding to array
                ids << id.to_i
              end
            end
          end

          ids
        end
      end
    end
  end
end
