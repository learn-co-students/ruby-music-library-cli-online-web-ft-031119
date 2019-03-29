require 'pry'

class MusicLibraryController
  attr_accessor :path, :importer
  def initialize(path = './db/mp3s')
    @path = path
    @importer = MusicImporter.new(@path)
    @importer.import
  end
  def call
    self.greeting
    user_input = ""
    while user_input != 'exit'
      puts "What would you like to do?"
      user_input = gets.chomp

      case user_input
      when 'list songs'
        self.list_songs
      when 'list artists'
        self.list_artists
      when 'list genres'
        self.list_genres
      when 'list genre'
        self.list_songs_by_genre
      when 'list artist'
        self.list_songs_by_artist
      when 'play song'
        self.play_song
      end

    end
  end

  def list_songs
    songs = Song.all.sort_by{|song| song.name}
    songs.each_with_index do |song,index|
      name = song.name
      artist = song.artist.name
      genre = song.genre.name
      puts "#{index+1}. #{artist} - #{name} - #{genre}"
    end
    songs
  end

  def list_artists
    artists = Artist.all.collect{|artist| artist.name}
    artists = (artists.uniq).sort
    artists.each_with_index{|artist,index| puts "#{index+1}. #{artist}"}
  end

  def list_genres
    genres = Genre.all.collect{|genre| genre.name}
    genres = (genres.uniq).sort
    genres.each_with_index{|genre,index| puts "#{index+1}. #{genre}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    user_input = gets.chomp
    artist = Artist.find_by_name(user_input)
    if artist
      songs = artist.songs.sort_by{|song| song.name}
      songs.each_with_index{|song,index| puts "#{index+1}. #{song.name} - #{song.genre.name}"}
    end
    songs
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    user_input = gets.chomp
    genres = Genre.find_by_name(user_input)
    if genres
      songs = genres.songs.sort_by{|song| song.genre.name}
      songs.each_with_index{|song,index| puts "#{index+1}. #{song.artist.name} - #{song.name}"}
    end
    songs
  end

  def play_song
    puts "Which song number would you like to play?"
    user_input = gets.chomp
    songs = Song.all.sort_by{|song| song.name}
    song = songs[user_input.to_i-1]
    if 1 <= user_input.to_i && user_input.to_i <= songs.length
      if song
        puts "Playing #{song.name} by #{song.artist.name}"
      end
    end

  end

  def greeting
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
  end

end
