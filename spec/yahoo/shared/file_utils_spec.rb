require 'spec_helper'

module Yahoo
  module Shared
    FileName = "message-01296.html"

    describe FileUtils do
      let(:path) do
        path = BasePath
      end

      let (:id) do
        id = 1296
      end

      describe "#format_filename" do
        it "should create a filename containing a 5 digit number" do
          html_fn = Yahoo::Shared::FileUtils.format_filename( path, id )

          html_fn.should == File.join( BasePath, 'message-01296.html')
        end
      end
    end
  end
end
