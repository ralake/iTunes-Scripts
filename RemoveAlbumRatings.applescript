tell application "iTunes" to set albumRatedTracks to every track whose album rating > 0
set trackCount to count of albumRatedTracks
set iconPath to (path to applications folder as text) & "iTunes.app:Contents:Resources:iTunes.icns"

tell application "SKProgressBar"
	activate
	tell main bar
		set minimum value to 0.0
		set maximum value to trackCount
		set current value to 0
		set header to "Removing all album ratings..."
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
			set currentTrack to item i of albumRatedTracks
			tell application "iTunes" to set album rating of currentTrack to 0
			tell main bar to increment by 1
		end repeat
		
		quit
	on error errStr number errorNumber
		quit
	end try
end tell