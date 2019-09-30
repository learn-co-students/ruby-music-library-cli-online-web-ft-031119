require "pry"
require_relative "./concerns/findable.rb"

class Song
  extend Concerns::Findable
  attr_accessor :name, :artist
  attr_reader :genre
  @@all = []
  
  def initialize(name, artist=nil, genre=nil)
    @name = name
    self.artist = artist
    if artist != nil
      artist.songs << self
    end
    
    self.genre = genre
    if genre != nil
      genre.songs << self
    end
    #@@all << self
  end
  
  def self.all
    @@all
  end
  
  def self.create(name)
    song = self.new(name)
    #song.save
    song
  end
  
  def self.destroy_all
    all.clear
  end
  
  def self.new_from_filename(file_name)
    data = file_name.split(/ - |\.mp3/)
    #binding.pry
    artist_name = data[0]
    song_name = data[1]
    genre_name = data[2]
    
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    song = Song.find_by_name(name)
    binding.pry
    if song == nil
      song = Song.new(song_name, artist, genre)
    else
      song.artist = artist
      song.genre = genre
      artist.songs << song
      genre.songs << song
    end
    
  end
  
  def self.create_from_filename(file_name)
    song = self.new_from_filename(file_name)
    song.save
  end
  
  def save
    self.class.all << self
  end
  
  def genre=(new_genre)
    if new_genre != nil
      @genre = new_genre
      if self.genre.songs.find_index(self) == nil
        self.genre.songs << self
      end
    end
  end
  
  def artist=(new_artist)
    @artist = new_artist
  end
end