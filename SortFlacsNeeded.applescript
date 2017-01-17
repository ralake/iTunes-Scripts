tell application "iTunes"
	set allTracks to every track whose kind is not "Apple Lossless audio file"
	set flacsNeededPlaylist to user playlist "Flacs Needed"
end tell

set trackCount to count of allTracks
set iconPath to (path to applications folder as text) & "iTunes.app:Contents:Resources:iTunes.icns"

tell application "SKProgressBar"
	activate
	tell main bar
		set minimum value to 0.0
		set maximum value to trackCount
		set current value to 0
		set header to "Moving non-lossless track to Flacs Needed..."
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
		repeat with currentTrack in allTracks
			tell "iTunes" to duplicate currentTrack to flacsNeededPlaylist
			tell main bar to increment by 1
		end repeat
		quit
	on error errStr number errorNumber
		quit
		display dialog errStr
	end try
end tell