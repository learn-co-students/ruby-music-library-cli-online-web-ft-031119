require "pry"
class MusicLibraryController
  
  def initialize(library_path ="./db/mp3s")
    @path = library_path
    @music_importer = MusicImporter.new(@path)
    @music_importer.import
  end
  
  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    
    input = gets.strip
    
    while input != "exit" do
      input = "exit"
    end
  end

  def list_songs
    songs = Song.all.sort_by {|a| a.name}
    #binding.pry
    songs.each_with_index do |e, index|
      str = "#{index+1}. #{e.artist.name} - #{e.name} - #{e.genre.name}"
      puts "#{str}"
    end
  end
  
  def list_artists
    artists = Artist.all.sort_by {|a| a.name}
    artists.each_with_index do |e, index|
      str = "#{index+1}. #{e.name}"
      puts "#{str}" 
    end
  end
  
  def list_genres
    genres = Genre.all.sort_by {|a| a.name}
    
    genres.each_with_index do |e, index|
      str = "#{index+1}. #{e.name}"
      puts "#{str}"
    end
  end
  
  def get_inputed_name(str)
    puts "Please enter the name of #{str}:"
    inputed_name = gets.strip
  end
  
  def list_songs_by_artist
    artist_name = get_inputed_name("an artist")
    index = Artist.all.find_index{|e| e.name == artist_name}
    if index != nil
      artist = Artist.all.fetch(index)
      songs = artist.songs.sort_by{|e| e.name}
      songs.each_with_index do |e, index|
        str = "#{index+1}. #{e.name} - #{e.genre.name}"
        puts "#{str}"
      end
    end
  end
  
  def list_songs_by_genre
    genre_name = get_inputed_name("a genre")
    index = Genre.all.find_index{|e| e.name = genre_name}
    #binding.pry
    if index != nil
      genre = Genre.all.fetch(index)
      songs = genre.songs.sort_by{|e| e.name}
      binding.pry
      songs.each_with_index do |e, index|
        str = "#{index+1}. #{e.artist.name} - #{e.name}"
        puts "#{str}"
      end
    end
  end
end