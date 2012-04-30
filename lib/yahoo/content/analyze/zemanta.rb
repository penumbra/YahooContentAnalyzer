module Yahoo
  module Content
    module Analyze
      class Zemanta
        attr_reader :doc


        def initialize
          # api_key, host, port, path
          prop = YAML::load_file( $ConfigFile )
          prop[ 'zemanta' ].each { |k, v| instance_variable_set("@#{k}", v ) }

          @request = {
            'method' => @method,
            'api_key' => @api_key,
            'format' => @format
          }
        end

        # return the Open Amplify API response as Nokogiri XML Doc
        def analyze( html )
          @request['text'] = html.msg

          response = Net::HTTP.post_form( URI.parse( @host ), @request )

          @doc = Nokogiri::XML( response.read_body )
        end

        def to_s
          Parse::Zemanta::parse_keywords( @doc ) do |kw|
            puts "keyword = #{kw}"
          end
        end
      end
    end  # Analyze
  end # Content
end # Yahoo