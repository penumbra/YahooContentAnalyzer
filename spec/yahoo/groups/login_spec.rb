require 'spec_helper'

module Yahoo
  class Config
    def login_id
      @login_id
    end
    def password
      @password
    end
  end

  module Groups
    describe Login do
      let(:config) do
        config = Yahoo::Config.new( Yahoo_Yml )
      end

      let(:username) do
        username = config.login_id
      end

      let(:password) do
        password = config.password
      end

      describe "#login" do
        it "should authenticate with Yahoo server" do
          STDOUT.should_receive(:puts).with( 'yahoo login successful...' )
          Yahoo::Groups::Login.new( username, password )
        end
      end
    end
  end
end