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
		set header to "Saving playlists to comments..."
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
				set tracksPlaylists to the playlists of theTrack
				set playlistComment to {}
				repeat with thePlaylist in tracksPlaylists
					set playlistName to name of the thePlaylist as string
					
					try
						set parentName to ((the name of thePlaylist's parent) as string)
						set playlistName to parentName & "*" & playlistName
					end try
					
					if playlistName is not "Artists" then set end of playlistComment to playlistName
				end repeat
				
				if playlistComment is not {} then
					tell helpers to set joinedList to join(playlistComment, "/")
					set comment of theTrack to joinedList
				end if
			end tell
			
			tell main bar to increment by 1
		end repeat
		quit
	on error errStr number errorNumber
		quit
	end try
end tell