require 'rubygems'
require 'fileutils'

module Yahoo
  class FileUtils
    # save
    def self.write_file( filename, html )
      puts "writing #{fn}..."
      File.open(filename, 'w') {|file| file.write( html ) }
    end

    def self.format_filename( path, id )
      fn = File::join( path, 'message' )
      fn = format("#{fn}-%05d.html", id)
    end

    def self.make_data_dir( path )
      FileUtils::mkdir( path )
    rescue
      # already exists
    end
  end
end
