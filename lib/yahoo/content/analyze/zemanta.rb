module Yahoo
  module Content
    module Analyze
      class Zemanta
        ApiHost = 'http://api.zemanta.com/services/rest/0.0/'
        attr_reader :doc

        def initialize( yahoo_yml )
          prop = YAML::load_file( yahoo_yml )

          @api_key = prop['zemanta']['api_key']

          @request = {
              'method' =>'zemanta.suggest',
              'api_key' => @api_key,
              'format' => 'xml'
          }
        end

        # return the Open Amplify API response as Nokogiri XML Doc
        def analyze( msg )
          @request['text'] = msg
          response = Net::HTTP.post_form( URI.parse( ApiHost ), @request )

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