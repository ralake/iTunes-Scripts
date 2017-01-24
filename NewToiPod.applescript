tell application "Finder" to set helpersPath to ((container of (path to me) as text) & "Helpers.scpt")
set helpers to (load script file helpersPath)

tell application "iTunes"
	with timeout of 6000 seconds
	set allTracks to every track in user playlist "Put on iPod"
	set alliPods to every source whose kind is iPod
	set myiPod to first item of alliPods
	set iPodMainLibrary to library playlist 1 of myiPod
	set iPodCurrentPlaylist to user playlist "Current" of myiPod
	set putOniPodPlaylist to playlist "Put on iPod"
	set losslessTracks to {}
	
	repeat with i from 1 to count of allTracks
		set currentTrack to item i of allTracks
		set fileType to kind of currentTrack as string
		
		if fileType is "Apple Lossless audio file" then
			set end of losslessTracks to currentTrack
		else
			tell helpers to addTrackToiPod(currentTrack, iPodMainLibrary, iPodCurrentPlaylist, false)
			tell helpers to removeTrackFromPlaylist(currentTrack, putOniPodPlaylist)
		end if
	end repeat
	
	if losslessTracks is not {} then
		set convertedLossless to convert losslessTracks
		
		repeat with i from 1 to count of convertedLossless
			set convertedTrack to item i of convertedLossless
			set losslessTrack to item i of losslessTracks
			
			tell helpers to addTrackToiPod(convertedTrack, iPodMainLibrary, iPodCurrentPlaylist, true)
			tell helpers to removeTrackFromPlaylist(losslessTrack, putOniPodPlaylist)
		end repeat
	end if
	end timeout
end tell