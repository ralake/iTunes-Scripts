tell application "iTunes" to set allTracks to every track whose rating > 0
set trackCount to count of allTracks
set iconPath to (path to applications folder as text) & "iTunes.app:Contents:Resources:iTunes.icns"

tell application "SKProgressBar"
	activate
	tell main bar
		set minimum value to 0.0
		set maximum value to trackCount
		set current value to 0
		set header to "Setting ratings to groupings..."
		set header alignment to center
		set header size to regular
		set footer alignment to center
		set image path to iconPath
	end tell
	
	set show window to true
	
	tell main bar
		set indeterminate to false
		start animation
	end tell
	
	try
		repeat with i from 1 to trackCount
			tell application "iTunes"
				set currentTrack to item i of allTracks
				set trackRating to rating of currentTrack as number
				set trackGrouping to grouping of currentTrack as number
				
				if trackRating is not equal to trackGrouping then set grouping of currentTrack to trackRating
			end tell
			
			tell main bar to increment by 1
		end repeat
		
		quit
	on error errStr number errorNumber
		quit
	end try
end tell