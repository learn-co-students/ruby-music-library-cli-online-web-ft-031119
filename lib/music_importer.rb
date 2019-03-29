require 'pry'
class MusicImporter

  attr_reader :path

  def initialize(path)
    @path = path
  end

  def files
    @files ||= Dir.glob("#{@path}/*.mp3")
    @files.map do |file|
      file_array = file.split("/")
      file = file_array.last
    end
  end

  def import
    files.each {|file| Song.create_from_filename(file)}
  end
end
