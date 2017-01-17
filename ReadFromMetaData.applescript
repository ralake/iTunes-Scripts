tell application "Finder" to set helpersPath to ((container of (path to me) as text) & "Helpers.scpt")
set helpers to (load script file helpersPath)
set iconPath to (path to applications folder as text) & "iTunes.app:Contents:Resources:iTunes.icns"
tell application "iTunes" to set allTracks to every track
set trackCount to count of allTracks

tell application "SKProgressBar"
	activate
	tell main bar
		set minimum value to 0.0
		set maximum value to trackCount
		set current value to 0
		set header to "Reading ratings and playlists from metadata..."
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
			set theTrack to item i of allTracks
			tell application "iTunes"
				set trackLocation to location of theTrack
				set trackPath to quoted form of POSIX path of trackLocation as string
				tell helpers to set trackRating to getMetaData("trackRating", trackPath)
				tell helpers to set trackPlaylists to getMetaData("trackPlaylists", trackPath)
				
				if trackRating is not null then set rating of theTrack to trackRating
				if trackPlaylists is not null then set comment of theTrack to trackPlaylists
			end tell
			
			tell main bar to increment by 1
		end repeat
		quit
	on error errStr number errorNumber
		quit
		display dialog errStr
	end try
end tell