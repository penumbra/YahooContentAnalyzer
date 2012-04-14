require 'spec_helper'

module Yahoo
  module Content
    ExpectedResult = [1297, 1298, 1299, 1308, 1302, 1303, 1309, 1314, 1316, 1315, 1317, 1320, 1322, 1323, 1336, 1340, 1342, 1353, 1366, 1451, 1452, 1453, 1455, 1461, 1463, 1466, 1486]

    describe FindLinks do
      describe "#find" do
        it "should return an array of message ids" do
          FindLinks.find( SampleHtml ).should == ExpectedResult
        end
      end
    end
  end
end