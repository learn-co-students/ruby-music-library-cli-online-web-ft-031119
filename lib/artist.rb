require "pry"
require_relative "./concerns/findable.rb"
class Artist
  
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
    artist = self.new(name)
    artist.save
    artist
  end
  
  def save
    self.class.all << self
  end
  
  def add_song(song)
    if song.artist == nil
      song.artist = self
    end

    if songs.find_index(song) == nil
      self.songs << song
    end
  end
  
  def genres
    arr_genre = []
    songs.each do |song|
      if arr_genre.find_index(song.genre) == nil
        arr_genre << song.genre
      end
    end
    arr_genre
  end
end