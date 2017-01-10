tell application "iTunes"
	repeat with theTrack in selection
		set theGrouping to grouping of theTrack
		if theGrouping is "1" then set grouping of theTrack to "20"
		if theGrouping is "2" then set grouping of theTrack to "40"
		if theGrouping is "3" then set grouping of theTrack to "60"
		if theGrouping is "4" then set grouping of theTrack to "80"
		if theGrouping is "5" then set grouping of theTrack to "100"
	end repeat
end tell