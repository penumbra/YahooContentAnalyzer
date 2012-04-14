require 'rubygems'
require 'fileutils'

module Yahoo
  module Shared
    class FileUtils
      # save
      def self.write_file( filename, html )
        puts "writing #{filename}..."
        File.open(filename, 'w') {|file| file.write( html ) }
      end

      def self.format_filename( path, id )
        fn = File::join( path, 'message' )
        format("#{fn}-%05d.html", id)
      end

      def self.make_data_dir( path )
        FileUtils::mkdir( path )
      rescue
        # already exists
      end
    end
  end
end
