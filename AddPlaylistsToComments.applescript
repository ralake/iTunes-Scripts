to join(aList, delim)
	set originalTID to text item delimiters
	set text item delimiters to delim
	set joined to aList as text
	set text item delimiters to originalTID
	return joined
end join

tell application "iTunes" to set allTracks to every track
set trackCount to count of allTracks

set progress total steps to trackCount
set progress description to "Saving playlists to comments..."

repeat with i from 1 to trackCount
	set theTrack to item i of allTracks
	
	tell application "iTunes"
		set tracksPlaylists to the playlists of theTrack
		set playlistComment to {}
		repeat with thePlaylist in tracksPlaylists
			set playlistName to name of the thePlaylist as string
			if playlistName is not "Artists" then set end of playlistComment to playlistName
		end repeat
		
		if playlistComment is not {} then
			set joinedList to my join(playlistComment, "/")
			set comment of theTrack to joinedList
		end if
	end tell
	
	set progress completed steps to i
end repeat