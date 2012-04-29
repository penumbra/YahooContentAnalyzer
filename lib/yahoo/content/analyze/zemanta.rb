module Yahoo
  module Content
    module Analyze
      class Zemanta < Yahoo::Shared::Config
        attr_reader :doc

        def initialize
          super( $ConfigFile )

          # api_key, host, port, path
          add_properties!( Yahoo::Shared::Config::ZemantaTag )

          @request = {
            'method' =>'zemanta.suggest',
            'api_key' => @api_key,
            'format' => 'xml'
          }
        end

        # return the Open Amplify API response as Nokogiri XML Doc
        def analyze( msg )
          @request['text'] = msg
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