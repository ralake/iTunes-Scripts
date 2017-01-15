tell application "iTunes" to set theTracks to selection
set trackCount to count of theTracks

set progress total steps to trackCount
set progress description to "Repairing groupings..."

repeat with i from 1 to trackCount
	set theTrack to item i of theTracks
	
	tell application "iTunes"
		set theGrouping to grouping of theTrack
		if theGrouping is "1" then set grouping of theTrack to "20"
		if theGrouping is "2" then set grouping of theTrack to "40"
		if theGrouping is "3" then set grouping of theTrack to "60"
		if theGrouping is "4" then set grouping of theTrack to "80"
		if theGrouping is "5" then set grouping of theTrack to "100"
	end tell
	
	set progress completed steps to i
end repeat
