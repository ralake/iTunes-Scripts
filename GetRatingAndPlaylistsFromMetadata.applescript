to getMetaData(key, filePath)
	try
		return do shell script "xattr -p com.apple.metadata:" & key & " " & filePath
	on error errMsg number errorNumber
		return null
	end try
end getMetaData

tell application "iTunes"
	set allTracks to selection
	-- set allTracks to every track
	repeat with theTrack in allTracks
		set trackLocation to location of theTrack
		set trackPath to quoted form of POSIX path of trackLocation as string
		
		set trackRating to my getMetaData("trackRating", trackPath)
		set trackPlaylists to my getMetaData("trackPlaylists", trackPath)
		
		if trackRating is not null then set rating of theTrack to trackRating
		if trackPlaylists is not null then set comment of theTrack to trackPlaylists
	end repeat
end tell