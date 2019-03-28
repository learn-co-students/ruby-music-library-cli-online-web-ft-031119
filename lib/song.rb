# require_relative '../lib/moddable.rb'
class Song
  attr_accessor :name
  @@all = []
  def initialize(name, artist = nil)
    if !(artist == nil)
      self.artist = artist
      # @artist = artist
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
    artist.add_song(self)
    @artist = artist
  end
  def artist
    @artist
  end

end
