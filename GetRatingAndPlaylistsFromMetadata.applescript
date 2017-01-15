tell application "Finder" to set helpersPath to ((container of (path to me) as text) & "Helpers.scpt")
set helpers to (load script file helpersPath)

tell application "iTunes" to set allTracks to every track
set trackCount to count of allTracks

set progress total steps to trackCount
set progress description to "Getting metadata..."

repeat with i from 1 to trackCount
	set theTrack to item i of allTracks
	tell application "iTunes"
		set trackPath to quoted form of POSIX path of trackLocation as string
		tell helpers to set trackRating to getMetaData("trackRating", trackPath)
		tell helpers to set trackPlaylists to getMetaData("trackPlaylists", trackPath)
		
		if trackRating is not null then set rating of theTrack to trackRating
		if trackPlaylists is not null then set comment of theTrack to trackPlaylists
	end tell
	
	set progress completed steps to i
end repeat