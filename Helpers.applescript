on locateiPod()
	set the volumes_directory to "/Volumes/" as POSIX file as alias
	set the volume_names to list folder volumes_directory without invisibles
	set mounted_iPods to {}
	repeat with i from 1 to the count of volume_names
		try
			set this_name to item i of volume_names
			set this_disk to ("/Volumes/" & this_name & "/") as POSIX file as alias
			set these_items to list folder this_disk
			if "iPod_Control" is in these_items then
				set the end of the mounted_iPods to this_disk
			end if
		end try
	end repeat
	
	-- check for iPod count
	if the mounted_iPods is {} then
		--
		try
			display dialog "iPod is not mounted." buttons {"Cancel"} with icon 0 giving up after 15
		on error
			error number -128
		end try
		
	else if the (count of the mounted_iPods) is greater than 1 then
		-- choose iPod
		set the ipod_names to {}
		repeat with i from 1 to the count of the mounted_iPods
			set this_iPod to item i of the mounted_iPods
			tell application "Finder"
				set the end of the ipod_names to the name of this_iPod
			end tell
		end repeat
		tell application "iTunes"
			activate
			set this_name to (choose from list ipod_names with prompt "Pick the iPod to use:") as string
		end tell
		if this_name is "false" then error number -128
		repeat with i from 1 to the count of the ipod_names
			if item i of the ipod_names is this_name then
				set this_iPod to item i of the mounted_iPods
				exit repeat
			end if
		end repeat
	else
		set this_iPod to item 1 of the mounted_iPods
	end if
	set theiPodName to text 1 thru -2 of (this_iPod as string)
	tell application "iTunes" to set ipodSrc to some source whose name is theiPodName
	return ipodSrc
	-- return this_iPod	
end locateiPod

on addTrackToiPod(theTrack, theiPod, thePlaylist, shouldDelete)
	tell application "iTunes"
		duplicate theTrack to theiPod
		if rating of theTrack > 0 then duplicate theTrack to thePlaylist
		if shouldDelete then delete theTrack
	end tell
end addTrackToiPod