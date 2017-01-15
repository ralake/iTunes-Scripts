to setMetaData(key, value, filePath)
	do shell script "xattr -w com.apple.metadata:" & key & " " & value & " " & filePath
end setMetaData

tell application "iTunes" to set allTracks to every track
set trackCount to count of allTracks

set progress total steps to trackCount
set progress description to "Saving metadata..."

repeat with i from 1 to trackCount
	set theTrack to item i of allTracks
	tell application "iTunes"
		set trackRating to rating of theTrack
		set trackPlaylists to comment of theTrack
		set trackPlaylists to quoted form of trackPlaylists
		set trackLocation to location of theTrack
		set trackPath to quoted form of POSIX path of trackLocation as string
		
		if trackRating is not 0 then my setMetaData("trackRating", trackRating, trackPath)
		if trackPlaylists is not quoted form of "" then my setMetaData("trackPlaylists", trackPlaylists, trackPath)
	end tell
	
	set progress completed steps to i
end repeat
