require_relative "./concerns/findable.rb"

class Genre
  extend Concerns::Findable
  attr_accessor :name, :songs
  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    all.clear
  end
  
  def self.create(name)
    genre = self.new(name)
    genre.save
    genre
  end
  
  def save
    self.class.all << self
  end
  
  def artists
    arr_artist = []
    songs.each do |song|
      if arr_artist.find_index(song.artist) == nil
        arr_artist << song.artist
      end
    end
    arr_artist
  end
  
end