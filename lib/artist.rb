class Artist
    extend Concerns::Findable # implicitly extends ClassMethods
    
    attr_accessor :name
    attr_reader :songs
    
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def self.create(name)
        artist = new(name)
        artist.save
        artist
    end

    def songs
        @songs
    end

    def genres
        @songs.collect { |s| s.genre }.uniq
    end

    def add_song(song)
        song.artist = self unless song.artist
        @songs << song unless @songs.include?(song)
    end

    def self.all
        @@all
    end

    def save
        @@all << self
    end

    def self.destroy_all
        self.all.clear
    end

end