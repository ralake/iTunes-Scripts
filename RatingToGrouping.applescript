set allTracks to {}
set trackCount to 0

tell application "iTunes"
	set allTracks to every track whose rating > 0
	set trackCount to count of allTracks
end tell

set progress total steps to trackCount
set progress description to "Convert rating to grouping..."

repeat with i from 1 to trackCount
	set trackName to ""
	
	tell application "iTunes"
		set currentTrack to item i of allTracks
		set trackRating to rating of currentTrack as number
		set trackGrouping to grouping of currentTrack as number
		
		if trackRating is not equal to trackGrouping then set grouping of currentTrack to trackRating
	end tell
	
	set progress completed steps to i
end repeat

