class Genre
    extend Concerns::Findable # implicitly extends ClassMethods

    attr_accessor :name
    attr_reader :songs
    
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def songs
        @songs
    end

    def artists
        @songs.collect {|song| song.artist}.uniq
    end

    def self.create(name)
        genre = Genre.new(name)
        genre.save
        genre
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