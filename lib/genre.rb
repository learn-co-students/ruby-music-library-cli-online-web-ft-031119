require_relative '../lib/concerns/findable.rb'
class Genre
  extend Concerns::Findable
  attr_accessor :name
  @@all = []
  def initialize(name)
    @songs = []
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
  def songs
    @songs
  end
  def add_song(song)
    if !song.artist
      song.artist = self
    end
    if !self.songs.include?(song)
      self.songs << song
    end
  end
  def artists
    (self.songs.collect {|song| song.artist}).uniq
  end
end
