PostRequest

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