require 'pry'
class Song 
extend  Concerns::Findable
  
attr_accessor :name , :artist, :genre, :song_info
@@all=[]

def initialize(name, artist=nil, genre=nil)
@name=name
self.artist= artist if artist !=nil
self.genre= genre if genre !=nil

end 

def self.all
  @@all
end 

def artist=(artist)
   @artist=artist
   @artist.add_song(self)
 end 

def self.destroy_all
  @@all.clear 
end 

def genre=(genre)
  @genre=genre
  genre.add_song(self)
end 

def save 
  @@all << self 
end 

def self.create(name) 
 created_song= self.new(name)
 created_song.save
 created_song 
 end 
 
 def self.new_from_filename(filename)
    @song_info = filename.chomp(".mp3").split(" - ")
    artist=@song_info[0]
    genre=@song_info[2]
    song=self.new(@song_info[1])
    song.artist= Artist.find_or_create_by_name(artist)
    song.genre= Genre.find_or_create_by_name(genre)
    song
end 

def self.create_from_filename(filename)
    self.new_from_filename(filename).save
end 
end 