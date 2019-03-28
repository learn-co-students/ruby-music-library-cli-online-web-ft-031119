# require_relative '../lib/moddable.rb'
class Song
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
  def self.find_by_name(name)
    self.all.find {|song| song.name == name}
  end
  def self.find_or_create_by_name(name)
    if self.find_by_name(name)
      return self.find_by_name(name)
    else
      self.create(name)
    end

  end

end
