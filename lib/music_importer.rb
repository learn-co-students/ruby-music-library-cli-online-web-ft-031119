class MusicImporter
  attr_accessor :path
  def initialize(filepath)
    @path = filepath
    @files = Dir[@path+"**/*.mp3"]
  end
  def files
    Dir[@path+"**/*.mp3"].collect{|p| p.split(@path+"/")[1]}
  end
  def import
    self.files.each {|filename| Song.create_from_filename(filename)}
  end

end
