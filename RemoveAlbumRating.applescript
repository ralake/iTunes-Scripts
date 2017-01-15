tell application "iTunes" to set albumRatedTracks to every track whose album rating > 0

set trackCount to count of albumRatedTracks
set progress total steps to trackCount
set progress description to "Removing album rating..."

repeat with i from 1 to trackCount
	set currentTrack to item i of albumRatedTracks
	tell application "iTunes" to set album rating of currentTrack to 0
	set progress completed steps to i
end repeat