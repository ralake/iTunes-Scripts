tell application "Finder" to set helpersPath to ((container of (path to me) as text) & "Helpers.scpt")
set helpers to (load script file helpersPath)

tell application "iTunes" to set allTracks to every track whose comments is not ""
tell application "iTunes" to set allPlaylists to name of user playlists
set trackCount to count of allTracks

set progress total steps to trackCount
set progress description to "Building playlists from comments..."

repeat with i from 1 to trackCount
	set theTrack to item i of allTracks
	
	tell application "iTunes"
		set tracksComment to comment of theTrack
		if tracksComment is not "" then
			tell helpers to set tracksPlaylists to split(tracksComment, "/")
			repeat with playlistName in tracksPlaylists
				if playlistName is not in allPlaylists then make new user playlist with properties {name:playlistName}
				duplicate theTrack to user playlist playlistName
			end repeat
		end if
	end tell
	
	set progress completed steps to i
end repeat