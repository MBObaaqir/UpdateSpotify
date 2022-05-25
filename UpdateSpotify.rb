require 'pry'
require 'json'

# Wrapper parser function ------------------------------------------------------

def update(input, changes, output)
  changes.each_line do |command|
    command = command.split
    if command[0] == "REMOVE" then
      if command[1] == "PLAYLIST"
        playlist = command[2]
        remove_playlist(input, playlist, output)
      end
    elsif command[0] == "ADD"
      if command[1..3].join(' ') == "SONGS TO PLAYLIST"
        playlist = command[4]
        command.shift(5)
        songs = command
        add_song_to_playlist(input, playlist, songs, output)
      elsif command[1..4].join(' ') == "NEW PLAYLIST TO USER"
        user_id = command[5]
        command.shift(6)
        songs = command
        add_new_playlist_to_user(input, user_id, songs, output)
      end
    end
  end
end

# Primary methods --------------------------------------------------------------

def remove_playlist(input, playlist_id, output_file)
  input['playlists'] = input['playlists'].select { |playlist|
    playlist['id'] != playlist_id
  }
  write_output(output_file, input)
end

def add_song_to_playlist(input, playlist_id, song_ids, output_file)
  input['playlists'].map do |playlist|
    if playlist['id'] == playlist_id then
      playlist['song_ids'] += song_ids
    end
  end
  write_output(output_file, input)
end

def add_new_playlist_to_user(input, user_id, songs, output_file)
  playlist_id = input['playlists'].last['id'].to_i + 1
  new_playlist = {
    "id" => playlist_id.to_s,
    "owner_id" => user_id,
    "song_ids" => songs
  }
  input['playlists'].push(new_playlist)
  write_output(output_file, input)
end

# Helpers ----------------------------------------------------------------------

def write_output(file, output)
  File.write(file, JSON.pretty_generate(output))
end

# Reading the input files and executing wrapper parser function ----------------

input = JSON.parse(File.read(ARGV[0]))
changes = File.read(ARGV[1])
output = ARGV[2]

update(input, changes, output)
