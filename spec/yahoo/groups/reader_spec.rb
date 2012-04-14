require 'spec_helper'

module Yahoo
  class Config
    def login_id
      @login_id
    end
    def password
      @password
    end
    def group_name
      @group_name
    end
  end

  module Groups
    describe Reader do
      let(:config) do
        config = Yahoo::Config.new( Yahoo_Yml )
      end

      let(:username) do
        username = config.login_id
      end

      let(:password) do
        password = config.password
      end

      # the Yahoo account use for this test is only subscribed to
      # one group: the group specified by "group_name"
      let(:group_name) do
        group_name = config.group_name
      end

      let(:reader) do
        reader = Yahoo::Groups::Reader.new( username, password )
      end

      describe "#list_groups" do
        it "should list several Yahoo group names" do
          list = reader.list_groups

          list[0].start_with?( group_name[0..5] ).should == true
        end
      end
    end
  end
end