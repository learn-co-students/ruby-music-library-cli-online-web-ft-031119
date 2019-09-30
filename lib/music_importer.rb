require "pry"
class MusicImporter
  
  attr_accessor :path
  
  def initialize(file_path)
    @path = file_path
  end
  
  def files
    #Dir.chdir(@path)
    #files = Dir.glob("*.mp3")
    #binding.pry
    files = Dir.glob("#{@path}/*.mp3")
    files = files.map {|e| File.basename(e)}
  end
  
  def import
    files.each do |file_name|
      Song.create_from_filename(file_name)
    end
  end
end