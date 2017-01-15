tell application "Finder" to set helpersPath to ((container of (path to me) as text) & "Helpers.scpt")
set helpers to (load script file helpersPath)

tell application "iTunes"
	set allTracks to every track in user playlist "Put on iPod"
	tell helpers to set ipodSrc to locateiPod()
	set myiPod to library playlist 1 of ipodSrc
	set iPodCurrentPlaylist to user playlist "Current" of ipodSrc
	
	repeat with i from 1 to count of allTracks
		set currentTrack to item i of allTracks
		set fileType to kind of currentTrack as string
		
		if fileType is "Apple Lossless audio file" then
			set convertedTrack to convert currentTrack
			repeat with theTrack in convertedTrack
				tell helpers to addTrackToiPod(theTrack, myiPod, iPodCurrentPlaylist, true)
			end repeat
		else
			tell helpers to addTrackToiPod(currentTrack, myiPod, iPodCurrentPlaylist, false)
		end if
		
		tell playlist "Put on iPod" to delete contents of currentTrack
	end repeat
end tell