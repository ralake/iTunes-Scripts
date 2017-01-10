to setMetaData(key, value, filePath)
	do shell script "xattr -w com.apple.metadata:" & key & " " & value & " " & filePath
end setMetaData

tell application "iTunes"
	set allTracks to selection
	-- set allTracks to every track
	repeat with theTrack in allTracks
		set trackRating to rating of theTrack
		set trackPlaylists to comment of theTrack
		set trackPlaylists to quoted form of trackPlaylists
		set trackLocation to location of theTrack
		set trackPath to quoted form of POSIX path of trackLocation as string
		
		if trackRating is not 0 then my setMetaData("trackRating", trackRating, trackPath)
		if trackPlaylists is not quoted form of "" then my setMetaData("trackPlaylists", trackPlaylists, trackPath)
	end repeat
end tell