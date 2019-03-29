require 'pry'
class Song
  @@all = []

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def self.find_by_name(name)
    @@all.detect{|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    song = find_by_name(name)
    if song
      return song
    else
      create(name)
    end
  end

  def self.new_from_filename(filename)
    file_array = filename.split(" - ")
    file_array[2] = file_array[2].gsub(".mp3", "")

    artist = Artist.find_or_create_by_name(file_array[0])
    genre = Genre.find_or_create_by_name(file_array[2])

    Song.new(file_array[1], artist, genre)
  end

  def self.create_from_filename(filename)
    song = Song.new_from_filename(filename)
    song.save
  end

  attr_accessor :name
  attr_reader :artist, :genre

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist unless artist.nil?
    self.genre = genre unless genre.nil?
  end

  def save
    @@all << self
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

end
