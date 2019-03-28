# require_relative '../lib/moddable.rb'
require_relative '../lib/concerns/concerns.rb'
class Song
  extend Concerns::Findable
  attr_accessor :name
  @@all = []
  def initialize(name, artist = nil, genre = nil)
    if !(artist == nil)
      self.artist = artist
    end
    if !(genre == nil)
      self.genre = genre
    end
    @name = name
    self.save
  end
  def self.all
    @@all
  end
  def self.destroy_all
    @@all.clear
  end
  def self.create(name)
    self.new(name)
  end
  def save
    self.class.all << self
  end
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  def artist
    @artist
  end
  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end
  def genre
    @genre
  end
  def self.new_from_filename(filename)
    artist_name,song_name,genre_name = filename[0,filename.length-4].split(" - ")
    song = Song.find_or_create_by_name(song_name)
    song.artist = Artist.find_or_create_by_name(artist_name)
    song.genre = Genre.find_or_create_by_name(genre_name)
    return song
  end
  def self.create_from_filename(filename)
    self.new_from_filename(filename)
  end

end
