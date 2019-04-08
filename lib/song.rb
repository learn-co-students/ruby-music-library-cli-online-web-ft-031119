require "pry"

class Song
    attr_accessor :name, :artist, :genre
    
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
    end

    def artist=(artist_obj)
        @artist = artist_obj
        @artist.add_song(self) 
    end

    def genre=(genre)
        @genre = genre
        @genre.songs << self unless @genre.songs.include?(self)
    end
    
    def save
        @@all << self
    end

    def self.new_from_filename(filename)
        parts = filename.chomp(".mp3").split(" - ")
        # won't work because expecting objects not strings
        # Song.new(parts[1], parts[0], parts[2])
        artist = Artist.find_or_create_by_name(parts[0])
        genre = Genre.find_or_create_by_name(parts[2])
        new(parts[1], artist, genre)
    end

    def self.create_from_filename(filename)
        new_from_filename(filename).save
    end

    def self.find_or_create_by_name(name)
        find_by_name(name) || create(name)
        
    end

    def self.find_by_name(name)
        @@all.detect{ |s| s.name == name}
    end

    def self.create(name)
        song = new(name)
        song.save
        song
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

end