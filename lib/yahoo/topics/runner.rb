module Yahoo
  module Topics
    attr_reader :all_topics

    # usage:
    #   tr = Topics::Runner( my_yaml_file )
    #
    class Runner
      # Tag used in YAML file to identify the Yahoo configuration block
      YahooConfigTag = 'yahoo'

      def initialize( yahoo_yml )
        prop = YAML::load_file( yahoo_yml )

        # create instance variables from the yahoo: group properties
        prop[YahooConfigTag].each { |key, value| instance_variable_set("@#{key}", value) }

        @all_topics = Set.new
      end

      def process_data
        entries = Dir.entries( @data_path )

        entries.each do |entry|
          fn = File.join( @data_path, entry )

          if File.directory?(fn) and (entry != '.' && entry != '..')
            puts "scanning files in #{entry}"
            find_topics( fn )
          end
        end
      end

      def find_topics( path )
        tf = Topics::Finder.new( path )
        tf.parse_files

        tf.topics.each do |topic|
          @all_topics << topic
        end

        puts "all topics: #{@all_topics.size}"
      end
    end
  end
end