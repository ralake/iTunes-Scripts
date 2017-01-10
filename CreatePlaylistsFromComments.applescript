to split(someText, delimiter)
	set AppleScript's text item delimiters to delimiter
	set someText to someText's text items
	set AppleScript's text item delimiters to {""} --> restore delimiters to default value
	return someText
end split

tell application "iTunes"
	set allTracks to selection
	set allPlaylists to name of user playlists
	
	repeat with theTrack in allTracks
		set tracksComment to comment of theTrack
		if tracksComment is not "" then
			-- splits the comment into separate playlist names
			set tracksPlaylists to my split(tracksComment, "/")
			repeat with playlistName in tracksPlaylists
				-- creates a new playlist if it doesnt already exist
				if playlistName is not in allPlaylists then set NewPlaylist to (make new user playlist with properties {name:playlistName})
				-- adds the track to the playlist if it hasn't already been added
				duplicate theTrack to user playlist playlistName
			end repeat
		end if
	end repeat
end tell