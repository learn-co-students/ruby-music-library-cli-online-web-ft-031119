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
      end
    end
  end

  def list_songs
    @importer.files.each_with_index {|file,index| puts "#{index+1}. #{file}."}
  end

  def list_artists

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
