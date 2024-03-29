require 'spec_helper'

module Yahoo
  module Groups
    GroupNameXPath = "//span[@class='ygrp-pname']"

    describe Reader do
      let(:group_name) do
        'SynchronicityPhenomena'
      end

      let(:reader) do
        reader = Yahoo::Groups::Reader.new
      end

      describe "#list_groups" do
        it "should list several Yahoo group names" do
          list = reader.list_groups

          list[0].start_with?( group_name[0..5] ).should == true
        end
      end

      describe "#select_group" do
        it "should select a Yahoo group" do
          html = reader.select_group

          get_group_name( html ).should == group_name
        end
      end

      # find this node in the html doc
      # <span class="ygrp-pname">SynchronicityPhenomena</span>
      def get_group_name( html )
        node = Nokogiri::HTML( html ).xpath( GroupNameXPath )
        node.text
      end
    end
  end
end