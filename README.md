# iTunes Scripts
Helper scripts to automate iTunes tasks

- Install the progress bar from http://macscripter.net/viewtopic.php?id=36409
- Place all scripts into `~/Library/iTunes/Scripts`
- Add these alias commands to `~/.bash_profile`...
```BASH
alias comments-to-playlists='to-itunes-scripts && osascript CommentsToPlaylists.scpt'
alias groupings-to-ratings='to-itunes-scripts && osascript GroupingsToRatings.scpt'
alias itunes-commands='echo -e "to-itunes-scripts\nnew-to-ipod\nplaylists-to-comments\nratings-to-groupings\ngroupings-to-ratings\nsort-flacs-needed\nsave-to-metadata\nread-from-metadata\ncomments-to-playlists\nremove-album-ratings"'
alias new-to-ipod='to-itunes-scripts && osascript NewToiPod.scpt'
alias playlists-to-comments='to-itunes-scripts && osascript PlaylistsToComments.scpt'
alias ratings-to-groupings='to-itunes-scripts && osascript RatingsToGroupings.scpt'
alias read-from-metadata='to-itunes-scripts && osascript ReadFromMetaData.scpt'
alias remove-album-ratings='to-itunes-scripts && osascript RemoveAlbumRatings.scpt'
alias save-to-metadata='to-itunes-scripts && osascript SaveToMetaData.scpt'
alias sort-flacs-needed='to-intunes-scripts && osascript SortFlacsNeeded.scpt'
alias to-itunes-scripts='cd ~/Library/iTunes/Scripts'
```

- `comments-to-playlists` - Takes the playlist data stored in the comments field (since iTunes doesn't keep playlist information for tracks in the files themselves) and rebuilds the playlists whilst adding tracks to them
- `groupings-to-ratings` - Takes ratings that have been stored in the grouping field (since iTunes doesn't keep ratings for tracks in the files themselves) and adds them to the track as a rating
- `itunes-commands` - Lists all bash commands for managing iTunes
- `new-to-ipod` - Adds everything in the "Put on iPod" playlist to the connected iPod, converting any lossless tracks to mp3 before deleting them. Removes all tracks from the "Put on iPod" playlist and adds any rated tracks into the iPod's "Current Playlist"
- `playlists-to-comments` - Adds playlist information for each track to it's comments field (since iTunes doesn't keep playlist information for tracks in the files themselves) so that playlist structures can be rebuilt
- `ratings-to-groupings` - Adds each rated tracks rating to the grouping field (since iTunes doesn't keep ratings for tracks in the files themselves) so that ratings can be recovered
- `read-from-metadata` - Reads a track's metadata (set using `xattr`) and sets any playlist data to the comments field and any ratings data to rating
- `remove-album-rating` - Removes the album rating for all tracks in iTunes
- `save-to-metadata` - Stores playlist and rating data for each track into the files metadata (using `xattr`) so that this information can be extracted in iTunes or other applications
- `sort-flacs-needed` - Adds all non-lossless tracks to a "Flacs Needed" playlist
- `to-itunes-scripts` - Changes directory to the iTunes Scripts folder
