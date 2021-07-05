require_relative "./concerns/findable.rb"

class Song 
  extend Concerns::Findable
  attr_accessor :name
  attr_reader :artist, :genre
  @@all=[]
  
  def initialize(name, artist=nil, genre=nil)
    @name=name 
    self.artist=artist if artist
    self.genre=genre if genre
  end
  
  def self.all 
    @@all 
  end
  
  def save
    @@all << self 
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def self.create(name)
    new=self.new(name)
    new.save
    new
  end
  
  def artist=(artist)
    @artist=artist 
    @artist.add_song(self)
  end
  
  def genre=(genre)
    @genre=genre
    @genre.add_song(self)
  end
  
  def self.new_from_filename(filename)
    song=self.find_or_create_by_name(filename.split(" - ")[1])
    song.artist= Artist.find_or_create_by_name(filename.split(" - ")[0])
    song.genre= Genre.find_or_create_by_name(filename.split(" - ")[2].chomp!(".mp3"))
    song
  end
  
  def self.create_from_filename(filename)
    song=self.new_from_filename(filename)
    song.save
  end
  
end