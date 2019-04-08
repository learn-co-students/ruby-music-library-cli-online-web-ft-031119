require "pry"

class MusicLibraryController
    attr_accessor :songs_az

    def initialize(path = "./db/mp3s")
        importer = MusicImporter.new(path)
        importer.import
    end

    def call
        response = nil

        while response != "exit" do
        
            messages = ["Welcome to your music library!",
            "To list all of your songs, enter 'list songs'.",
            "To list all of the artists in your library, enter 'list artists'.",
            "To list all of the genres in your library, enter 'list genres'.",
            "To list all of the songs by a particular artist, enter 'list artist'.",
            "To list all of the songs of a particular genre, enter 'list genre'.",
            "To play a song, enter 'play song'.",
            "To quit, type 'exit'.", 
            "What would you like to do?"]

            messages.each do |phrase|
                puts phrase
            end

            response = gets.chomp

            case response
            when "list songs"
                list_songs
            when "list artists"
                list_artists
            when "list artist"
                list_songs_by_artist
            when "list genres"
                list_genres
            when "list genre"
                list_songs_by_genre
            when "play song"
                play_song
            else
            end
        end
    end

    def list_songs
        alphabetize_songs
        # songs_az = Song.all.sort_by {|song| song.name}
        @songs_az.each_with_index {|song, index|
            index += 1
            puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        }
    end

    def list_artists
        artists_az = Artist.all.sort_by {|artist| artist.name}
        artists_az.each_with_index {|artist, index|
            index += 1
            puts "#{index}. #{artist.name}"
        }
    end
    
    def list_genres
        genres_az = Genre.all.sort_by {|genre| genre.name}
        genres_az.each_with_index {|genre, index|
            index += 1
            puts "#{index}. #{genre.name}"
        }
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        artist = gets.chomp
        match = Artist.all.detect {|a| a.name == artist}
        if match
            match.songs.sort_by {|song| song.name}.each_with_index {|s, index| 
                index += 1
                puts "#{index}. #{s.name} - #{s.genre.name}"
            }
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        genre = gets.chomp
        match = Genre.all.detect {|g| g.name == genre}
        if match
            match.songs.sort_by {|song| song.name}.each_with_index {|s, index| 
                index += 1
                puts "#{index}. #{s.artist.name} - #{s.name}"
            }
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        alphabetize_songs
        song_num = gets.chomp.to_i

        if song_num > 0 && song_num <= @songs_az.size
            song = @songs_az[song_num - 1] 
            puts "Playing #{song.name} by #{song.artist.name}"
        end
    end

    def alphabetize_songs
        @songs_az = Song.all.sort_by {|song| song.name}
    end
end