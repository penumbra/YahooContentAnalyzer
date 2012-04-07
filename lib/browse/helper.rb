module Browse
  class Helper
    def self.save( filename, html )
      File.open(filename, 'w') {|file| file.write( html ) }
    end
  end
end