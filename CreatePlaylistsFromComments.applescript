to split(someText, delimiter)
	set AppleScript's text item delimiters to delimiter
	set someText to someText's text items
	set AppleScript's text item delimiters to {""} --> restore delimiters to default value
	return someText
end split

tell application "iTunes" to set allTracks to every track whose comments is not ""
tell application "iTunes" to set allPlaylists to name of user playlists
set trackCount to count of allTracks

set progress total steps to trackCount
set progress description to "Building playlists from comments..."

repeat with i from 1 to trackCount
	set theTrack to item i of allTracks
	
	tell application "iTunes"
		set tracksComment to comment of theTrack
		if tracksComment is not "" then
			set tracksPlaylists to my split(tracksComment, "/")
			repeat with playlistName in tracksPlaylists
				-- creates a new playlist if it doesnt already exist
				if playlistName is not in allPlaylists then set NewPlaylist to (make new user playlist with properties {name:playlistName})
				-- adds the track to the playlist if it hasn't already been added
				duplicate theTrack to user playlist playlistName
			end repeat
		end if
	end tell
	
	set progress completed steps to i
end repeat