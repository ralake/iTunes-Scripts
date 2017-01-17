tell application "Finder" to set helpersPath to ((container of (path to me) as text) & "Helpers.scpt")
set helpers to (load script file helpersPath)
tell application "iTunes" to set allTracks to every track
set totalTrackCount to count of allTracks
set iconPath to (path to applications folder as text) & "iTunes.app:Contents:Resources:iTunes.icns"

tell application "SKProgressBar"
	activate
	tell main bar
		set minimum value to 0.0
		set maximum value to totalTrackCount
		set current value to 0
		set header to "Writing ratings and playlists to metadata..."
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
		repeat with theTrack in allTracks
			tell application "iTunes"
				set trackLocation to location of theTrack
				set trackPath to quoted form of POSIX path of trackLocation as string
				set trackRating to rating of theTrack
				set trackPlaylists to comment of theTrack
				set trackPlaylists to quoted form of trackPlaylists
				tell helpers to set storedTrackRating to getMetaData("trackRating", trackPath)
				tell helpers to set storedTrackPlaylists to getMetaData("trackPlaylists", trackPath)
				
				-- if the track is not rated but we have rating metadata in the file, delete the metadata
				if trackRating is 0 and storedTrackRating is not null then tell helpers to removeMetaData("trackRating", trackPath)
				-- if the track is not in any playlists but we have playlist metadata in the file, delete the metadata
				if trackPlaylists is "" and storedTrackPlaylists is not null then tell helpers to removeMetaData("trackPlaylists", trackPath)
				
				-- if the track has a rating
				if trackRating > 0 then
					-- if there is no metadata, set it
					if storedTrackRating is null then
						tell helpers to setMetaData("trackRating", trackRating, trackPath)
						-- if there is metadata
					else
						set storedTrackRating to storedTrackRating as number
						-- if the metadata is different to the rating, reset the metadata
						if storedTrackRating is not trackRating then tell helpers to setMetaData("trackRating", trackRating, trackPath)
					end if
				end if
				
				-- if the track is part of a playlist
				if trackPlaylists is not "" then
					-- if there is no metadata, set it
					if storedTrackPlaylists is null then
						tell helpers to setMetaData("trackPlaylists", trackPlaylists, trackPath)
						-- if there is metadata
					else
						if storedTrackPlaylists is not trackPlaylists then tell helpers to setMetaData("trackPlaylists", trackPlaylists, trackPath)
					end if
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