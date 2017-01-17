-- progress bar download - http://macscripter.net/viewtopic.php?id=36409

on addTrackToiPod(theTrack, theiPod, thePlaylist, shouldDelete)
	tell application "iTunes"
		duplicate theTrack to theiPod
		if rating of theTrack > 0 then duplicate theTrack to thePlaylist
		if shouldDelete then
			set trackLocation to location of theTrack
			delete theTrack
			tell application "Finder" to delete trackLocation
		end if
	end tell
end addTrackToiPod

on split(someText, delimiter)
	set AppleScript's text item delimiters to delimiter
	set someText to someText's text items
	set AppleScript's text item delimiters to {""}
	return someText
end split

on join(aList, delim)
	set originalTID to text item delimiters
	set text item delimiters to delim
	set joined to aList as text
	set text item delimiters to originalTID
	return joined
end join

on getMetaData(metadataKey, filePath)
	try
		return do shell script "xattr -p com.apple.metadata:" & metadataKey & " " & filePath
	on error errMsg number errorNumber
		return null
	end try
end getMetaData

on setMetaData(metadataKey, value, filePath)
	do shell script "xattr -w com.apple.metadata:" & metadataKey & " " & value & " " & filePath
end setMetaData

on removeMetaData(metadataKey, filePath)
	do shell script "xattr -d com.apple.metadata:" & metadataKey & " " & filePath
end removeMetaData

on removeTrackFromPlaylist(theTrack, thePlaylist)
	tell application "iTunes" to tell thePlaylist to delete contents of theTrack
end removeTrackFromPlaylist