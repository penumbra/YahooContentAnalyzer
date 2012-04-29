require 'spec_helper'

module Yahoo
  module Content
    module Analyze
      describe Html do
        ExpectedResult = [1297, 1298, 1299, 1308, 1302, 1303, 1309, 1314, 1316, 1315, 1317, 1320, 1322, 1323, 1336, 1340, 1342, 1353, 1366, 1451, 1452, 1453, 1455, 1461, 1463, 1466, 1486]

        let(:html) do
          html = Html.new
        end

        describe "#find" do
          it "should return an array of message ids" do
            html.analyze( SampleHtml )

            html.message_links.should == ExpectedResult
          end
        end
      end
    end # Analyze
  end # Content
end # Yahoo
