to join(aList, delim)
	set originalTID to text item delimiters
	set text item delimiters to delim
	set joined to aList as text
	set text item delimiters to originalTID
	return joined
end join

tell application "iTunes"
	set allTracks to every track
	repeat with theTrack in allTracks
		set tracksPlaylists to the playlists of theTrack
		set playlistComment to {}
		repeat with thePlaylist in tracksPlaylists
			set playlistName to name of the thePlaylist as string
			if playlistName is not "Artists" then set end of playlistComment to playlistName
		end repeat
		
		-- If playlists were found and added to the list
		if playlistComment is not {} then
			set joinedList to my join(playlistComment, "/")
			set comment of theTrack to joinedList
		end if
	end repeat
end tell