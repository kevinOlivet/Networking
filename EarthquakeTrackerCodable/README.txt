EarthquakeTracker2
(Swift 4)

This was a project as part of an interview assessment.
It retrieves data about earthquakes from a government website and parses it.
The original parsing strategy uses Swift 3.  
This one is a newer version using Swift that 4 and the Codable protocol.
This implementation allows for a stronger and more flexible model.

The retrieved data is first displayed in a tableView with editing capabilities.
Deleting and rearranging the table are supported.
It also implements pull to refresh to retrieve new data.
If a row is selected it will display the corresponding info in a mapView.
The selected earthquake will be centered with the callout displayed.
The other earthquakes will also be shown and when selected display information.
This version uses the "place" data instead of the "id".

This will be useful for future projects because of the clean implementation of the DownloadManager class.
It implements a static function to retrieve data with a completion closure,
so the data is available throughout the project.
The download logic is contained and it will be easy to import to any project.
The only thing I'll have to do is adjust the model to match the data.

For a little bit of flair the tableView is animated in ViewDidLoad and in the refresh.
:)