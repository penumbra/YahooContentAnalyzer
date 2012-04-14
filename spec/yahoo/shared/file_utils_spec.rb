require 'spec_helper'
require 'fileutils'

module Yahoo
  module Shared
    describe FileUtils do
      FileName = "message-01296.html"
      TestPath = File.join( BasePath, 'xxx' )

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

      describe "#make_data_dir" do
        it "should create a folder" do
          Yahoo::Shared::FileUtils.make_data_dir( TestPath )

          File.exists?( TestPath ).should == true
          ::FileUtils.rmdir( TestPath )
        end
      end
    end
  end
end
