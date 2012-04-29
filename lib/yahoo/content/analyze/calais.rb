module Yahoo
  module Content
    module Analyze
      class Calais < Yahoo::Shared::Config
        attr_reader :doc

        def initialize
          super( $ConfigFile )

          # api_key, host
          add_properties!( Yahoo::Shared::Config::OpenCalaisTag )

          @uri = URI.parse( @host )

          headers = {
            'Accept' => 'xml/rdf',    # 'Accept' => 'application/json',
            'x-calais-licenseID' => @api_key,
            'Content-Type' => 'text/xml; charset=UTF-8',
            'enableMetadataType' => 'SocialTags',
            'http.useragent' => 'Calais Rest Client',
          }

          @post = Net::HTTP::Post.new( @uri.path, headers )
        end

        def analyze( html )
          set_form_data( { 'title' => html.topic, 'datetime' => html.date, 'content' => html.msg } )

          response = Net::HTTP.start( @uri.host, @uri.port ) do |http|
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
        def set_form_data( request  )
          @post.set_form_data( request )
        end
      end
    end  # Analyze
  end # Content
end # Yahoo
