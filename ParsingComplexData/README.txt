ParsingComplex

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