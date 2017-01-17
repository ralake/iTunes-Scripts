tell application "Finder" to set helpersPath to ((container of (path to me) as text) & "Helpers.scpt")
set helpers to (load script file helpersPath)
set iconPath to (path to applications folder as text) & "iTunes.app:Contents:Resources:iTunes.icns"
tell application "iTunes" to set allTracks to every track whose comment is not ""
set trackCount to count of allTracks

tell application "SKProgressBar"
	activate
	tell main bar
		set minimum value to 0.0
		set maximum value to trackCount
		set current value to 0
		set header to "Building playlists from comments..."
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
				set tracksComment to comment of theTrack
				if tracksComment is not "" then
					tell helpers to set tracksPlaylists to split(tracksComment, "/")
					
					repeat with playlistName in tracksPlaylists
						tell application "iTunes" to set allUserPlaylists to name of user playlists
						tell helpers to set splitPlaylist to split(playlistName, "*")
						set allFolderPlaylists to ""
						
						try
							tell application "iTunes" to set allFolderPlaylists to name of folder playlists
						end try
						
						if (count of splitPlaylist) is greater than 1 then
							set folderPlaylistName to item 1 of splitPlaylist
							set subPlaylistName to item 2 of splitPlaylist
							
							if folderPlaylistName is not in allFolderPlaylists then make new folder playlist with properties {name:folderPlaylistName}
							if subPlaylistName is not in allUserPlaylists then make new user playlist at folder playlist folderPlaylistName with properties {name:subPlaylistName}
							
							duplicate theTrack to user playlist subPlaylistName
						else
							if playlistName is not in allUserPlaylists then make new user playlist with properties {name:playlistName}
							duplicate theTrack to user playlist playlistName
						end if
					end repeat
				end if
			end tell
			
			tell main bar to increment by 1
		end repeat
		quit
	on error errStr number errorNumber
		quit
		display dialog errStr
	end try
end tell