class Genre
  extend Concerns::Findable

  attr_accessor :name
  attr_reader :songs
  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def save
    @@all << self
  end

  def songs
    @songs
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(genre_name)
    genre_name = Genre.new(genre_name)
    genre_name.save
    genre_name
  end

  def add_songs(song)
    song.genre = self unless song.genre
    songs << song unless songs.include?(song)
  end

  def artists
    songs.collect {|song| song.artist}.uniq
  end

end
