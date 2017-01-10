set allTracks to {}
set trackCount to 0

tell application "iTunes"
	set allTracks to every track whose grouping is not ""
	set trackCount to count of allTracks
end tell

set progress total steps to trackCount
set progress description to "Convert grouping to rating..."

repeat with i from 1 to trackCount
	tell application "iTunes"
		set currentTrack to item i of allTracks
		set trackRating to rating of currentTrack as number
		set trackGrouping to 0
		
		try
			set trackGrouping to grouping of currentTrack as number
		end try
		
		if trackGrouping is not equal to 0 and trackGrouping is not equal to trackRating then
			set rating of currentTrack to trackGrouping
		end if
	end tell
	
	set progress completed steps to i
end repeat

