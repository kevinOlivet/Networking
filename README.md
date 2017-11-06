# Networking
Using RESTful api to receive information from endpoints

This collection of projects demonstrates how to receive and post information from the web and parse it's json into a usable format.
Where possible I've included the Swift 3 way to do it using JSONSerialization usually commented out and the Swift 4 way using the Codable protocol.

#EarthquakeTracker2
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


#EarthquakeTracker

This was a project is very similar to EarthquakeTrackerCodable.
It retrieves data about earthquakes from a government website and parses it.
The parsing strategy uses Swift 3.


#PostRequest

This project uses URLSession to make GET and POST requests.
It uses Swift 4 and the Codable protocol to encode and decode the requests
as well as JSONSerialization.

There is an enum Which with 3 choices to determine how much information is uploaded to the server.
Which.parameters initiates a simple dictionary and uses JSONSerialization to prepare it for the httpBody.
Which.partModel uses JSONEncode().encode to post a small part of the model: the company.
Which.wholeModel uses JSONEncode().encode to post the entire model!

The enum Which choice also affects the decoding of the response data.

Of particular note is the use of:
request.addValue("application/json", forHTTPHeaderField: "Content-Type")
This allows the response data to be read in the expected json format.

The GET implementation is pretty standard.


#ParsingComplex

For practice using the Codable protocol in Swift 4
I went in search of the most complex json data structure I could find.
I saw online that this one was considered especially difficult:
https://adobe.github.io/Spry/samples/data_region/JSONDataSetSample.html#Example10

I copied the structure and added it to the project
in a txt file and used it in the project using Bundle.main.path(forResource:, ofType:)
to mock the data that could be returned from an api call.

Then I broke it down into it's component structure.

Please note that the structs don't have to be nested
and could be separated out for easier access and use.
I nested them to exactly mirror the structure of the data.
