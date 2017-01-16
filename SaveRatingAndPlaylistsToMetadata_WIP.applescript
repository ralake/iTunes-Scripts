tell application "Finder" to set helpersPath to ((container of (path to me) as text) & "Helpers.scpt")
set helpers to (load script file helpersPath)

tell application "iTunes" to set allRatedTracks to every track whose rating > 0
tell application "iTunes" to set allPlaylistedTracks to every track whose comment is not ""
set allRatedTracksCount to count of allRatedTracks
set allPlaylistedTracksCount to count of allPlaylistedTracks
set totalTrackCount to allRatedTracksCount + allPlaylistedTracksCount

set progress total steps to totalTrackCount
set progress description to "Saving metadata..."

repeat with i from 1 to allRatedTracksCount
	set theTrack to item i of allRatedTracks
	tell application "iTunes"
		set trackRating to rating of theTrack
		set trackLocation to location of theTrack
		set trackPath to quoted form of POSIX path of trackLocation as string
		tell helpers to setMetaData("trackRating", trackRating, trackPath)
	end tell
	
	set progress completed steps to i
end repeat

repeat with i from (allRatedTracksCount + 1) to allPlaylistedTracksCount
	set theTrack to item i of allPlaylistedTracks
	tell application "iTunes"
		set trackPlaylists to comment of theTrack
		set trackPlaylists to quoted form of trackPlaylists
		set trackLocation to location of theTrack
		set trackPath to quoted form of POSIX path of trackLocation as string
		
		if trackPlaylists is not quoted form of "" then tell helpers to setMetaData("trackPlaylists", trackPlaylists, trackPath)
	end tell
	
	set progress completed steps to i
end repeat