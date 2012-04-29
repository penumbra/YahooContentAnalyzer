require 'spec_helper'

module Yahoo
  module Groups
    describe Login do
      describe "#login" do
        it "should authenticate with Yahoo server" do
          STDOUT.should_receive(:puts).with( 'yahoo login successful...' )
          Yahoo::Groups::Login.new( Yahoo_Yml )
        end
      end
    end
  end
end