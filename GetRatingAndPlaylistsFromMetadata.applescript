to getMetaData(key, filePath)
	try
		return do shell script "xattr -p com.apple.metadata:" & key & " " & filePath
	on error errMsg number errorNumber
		return null
	end try
end getMetaData

tell application "iTunes" to set allTracks to every track
set trackCount to count of allTracks

set progress total steps to trackCount
set progress description to "Getting metadata..."

repeat with i from 1 to trackCount
	set theTrack to item i of allTracks
	tell application "iTunes"
		set trackPath to quoted form of POSIX path of trackLocation as string
		set trackRating to my getMetaData("trackRating", trackPath)
		set trackPlaylists to my getMetaData("trackPlaylists", trackPath)
		
		if trackRating is not null then set rating of theTrack to trackRating
		if trackPlaylists is not null then set comment of theTrack to trackPlaylists
	end tell
	
	set progress completed steps to i
end repeat