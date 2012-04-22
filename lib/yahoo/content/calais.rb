module Yahoo
  module Content
    class Calais
      ApiHost = 'http://api.opencalais.com/tag/rs/enrich'

      attr_reader :doc

      def initialize( yahoo_yml )
        prop = YAML::load_file( yahoo_yml )

        @api_key = prop['open_calais']['api_key']

        @uri = URI.parse( ApiHost )

        headers = {
          'Accept' => 'xml/rdf',
          'x-calais-licenseID' => @api_key,
          'Content-Type' => 'text/xml; charset=UTF-8',
          'enableMetadataType' => 'SocialTags',
          'http.useragent' => 'Calais Rest Client',
        }

        @post = Net::HTTP::Post.new( @uri.path, headers )
      end

      def analyze( title, msg, date )
        set_form_data( title, msg, date )

        response = Net::HTTP.start( @uri.hostname, @uri.port ) do |http|
          # post contains form data _and_ HTTP headers
          http.request( @post )
        end

        @doc = Nokogiri::XML( response.read_body )
      end

      def to_s
        Parse::Calais::parse( @doc ) do |k, v|
            puts "#{k} => #{v}"
        end
      end

    protected
      # Open Calais supportted XML tags:
      # TITLE, HEADLINE, HEADER
      # BODY, DESCRIPTION, CONTENT
      # DATE, DATETIME, DATEANDTIME, PUBDATE
      def set_form_data( title, msg, date )
        request = {
          'title' => title,
          'content' => msg,
          'datetime' => date
        }

        @post.set_form_data( request )
      end
    end
  end
end
