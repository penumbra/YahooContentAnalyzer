module Browse
  class Content
    attr_reader :agent

    def initialize( agent )
      @agent = agent
    end

    def get_links_at( url )
      set_page_at( url )
      @agent.page.links
    end

    def set_page_at( url )
      @agent.get( url )
    end

    def click_link_with_title( url, title )
      set_page_at( url )

      find_link_by_title( title ).click
    end

    def find_link_by_title( title )
      if @agent == nil || @agent.page == nil
        raise "No current page - use set_page_at method"
      end

      @agent.page.links.each do |link|
        # Nokogiri::XML::Attr
        title_attr = link.attributes.attributes['title']

        if title_attr != nil && title_attr.to_s.empty? == false
          if title_attr.to_s == title
            return link
          end
        end
      end

      nil
    end
  end
end
